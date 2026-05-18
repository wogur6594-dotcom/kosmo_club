package com.club.app.productChat;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.club.app.member.MemberDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ProductChatHandler extends TextWebSocketHandler {

	private final ObjectMapper objectMapper;
	private final ChatService chatService;

	private final Map<Long, List<WebSocketSession>> roomSessions = new ConcurrentHashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) {

		Long chatroomNum = Long.valueOf(session.getAttributes().get("chatroomNum").toString());

		roomSessions.putIfAbsent(chatroomNum, new CopyOnWriteArrayList<>());

		roomSessions.get(chatroomNum).add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		ChatMessageDTO dto = objectMapper.readValue(message.getPayload(), ChatMessageDTO.class);

		Authentication auth = (Authentication) session.getPrincipal();
		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		Long roomNum = dto.getChatroomNum();

		// =========================
		// 🔥 READ 이벤트
		// =========================
		if ("read".equals(dto.getType())) {

			chatService.markAsRead(roomNum, loginUser.getMemberNum());

			dto.setSenderNum(loginUser.getMemberNum());
			dto.setIsRead(true);

			for (WebSocketSession s : roomSessions.get(roomNum)) {
				if (s.isOpen()) {
					s.sendMessage(new TextMessage(objectMapper.writeValueAsString(dto)));
				}
			}
			return;
		}

		// =========================
		// 🔥 MESSAGE 이벤트
		// =========================
		dto.setSenderNum(loginUser.getMemberNum());
		dto.setSenderName(loginUser.getMemberId());
		dto.setCreatetime(LocalDateTime.now());
		dto.setIsRead(false); // 🔥 중요

		chatService.addMessage(dto);

		List<WebSocketSession> sessions = roomSessions.get(roomNum);

		if (sessions != null) {
			for (WebSocketSession s : sessions) {
				if (s.isOpen()) {
					s.sendMessage(new TextMessage(objectMapper.writeValueAsString(dto)));
				}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {

		Long chatroomNum = Long.valueOf(session.getAttributes().get("chatroomNum").toString());

		List<WebSocketSession> sessions = roomSessions.get(chatroomNum);

		if (sessions != null) {
			sessions.remove(session);

			if (sessions.isEmpty()) {
				roomSessions.remove(chatroomNum);
			}
		}
	}
}