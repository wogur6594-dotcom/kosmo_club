package com.club.app.club.chat;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class ClubChatHandler extends TextWebSocketHandler {

	private final ClubMessageService clubMessageService;

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

		String time = java.time.LocalTime.now()
				.withSecond(0)
				.withNano(0)
				.toString();

		String sendMessage =
				"<strong>" + memberName + "</strong> : "
				+ contents
				+ " <span style='font-size:12px; color:gray;'>("
				+ time
				+ ")</span>";

		for (WebSocketSession s : rooms.get(clubNum)) {
			if (s.isOpen()) {
				s.sendMessage(new TextMessage(sendMessage));
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session,
			org.springframework.web.socket.CloseStatus status) throws Exception {

		Long clubNum = (Long) session.getAttributes().get("clubNum");

		if (rooms.get(clubNum) != null) {
			rooms.get(clubNum).remove(session);
		}
	}
}