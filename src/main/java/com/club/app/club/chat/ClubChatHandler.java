package com.club.app.club.chat;

import java.time.LocalTime;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ClubChatHandler extends TextWebSocketHandler {

	private final ClubMessageService clubMessageService;

	private final ObjectMapper objectMapper;

	private static final Map<Long, Set<WebSocketSession>> rooms = new ConcurrentHashMap<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		Long clubNum = (Long) session.getAttributes().get("clubNum");

		rooms.putIfAbsent(clubNum, ConcurrentHashMap.newKeySet());
		rooms.get(clubNum).add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		Long clubNum = (Long) session.getAttributes().get("clubNum");
		Long memberNum = (Long) session.getAttributes().get("memberNum");
		String memberName = (String) session.getAttributes().get("memberName");

		String contents = message.getPayload();

		ClubMessageDTO dto = new ClubMessageDTO();
		dto.setClubNum(clubNum);
		dto.setSenderNum(memberNum);
		dto.setMessageContents(contents);

		clubMessageService.insert(dto);

		String time = LocalTime.now().withSecond(0).withNano(0).toString();

		Map<String, Object> sendData = Map.of("memberNum", memberNum, "senderName", memberName, "messageContents",
				contents, "chatTime", time);

		String json = objectMapper.writeValueAsString(sendData);

		Set<WebSocketSession> room = rooms.get(clubNum);

		if (room == null) {
			return;
		}

		for (WebSocketSession s : room) {
			if (s.isOpen()) {
				s.sendMessage(new TextMessage(json));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		Long clubNum = (Long) session.getAttributes().get("clubNum");

		Set<WebSocketSession> room = rooms.get(clubNum);

		if (room != null) {
			room.remove(session);

			if (room.isEmpty()) {
				rooms.remove(clubNum);
			}
		}
	}
}