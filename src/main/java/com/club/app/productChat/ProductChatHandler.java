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
public class ProductChatHandler extends TextWebSocketHandler {

	private final ObjectMapper objectMapper;
	private final ChatService chatService;
	private final com.club.app.notification.NotificationService notificationService;
	
	// 방별 세션 (Detail view 전용)
	private final Map<Long, List<WebSocketSession>> roomSessions = new ConcurrentHashMap<>();
	// 사용자별 모든 세션 (List view + Detail view 통합)
	private final Map<Long, List<WebSocketSession>> userSessions = new ConcurrentHashMap<>();

	@org.springframework.beans.factory.annotation.Autowired
	public ProductChatHandler(ObjectMapper objectMapper, ChatService chatService, com.club.app.notification.NotificationService notificationService) {
		this.objectMapper = objectMapper;
		this.chatService = chatService;
		this.notificationService = notificationService;
	}

	@Override
	public void afterConnectionEstablished(WebSocketSession session) {

		Map<String, Object> attrs = session.getAttributes();
		String chatroomNumStr = (String) attrs.get("chatroomNum");

		Authentication auth = (Authentication) session.getPrincipal();
		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();
		Long memberNum = loginUser.getMemberNum();

		// 사용자별 세션 추가
		userSessions.putIfAbsent(memberNum, new CopyOnWriteArrayList<>());
		userSessions.get(memberNum).add(session);

		// 방별 세션 추가 (숫자일 때만)
		if (chatroomNumStr != null && !chatroomNumStr.equals("list")) {
			try {
				Long chatroomNum = Long.valueOf(chatroomNumStr);
				roomSessions.putIfAbsent(chatroomNum, new CopyOnWriteArrayList<>());
				roomSessions.get(chatroomNum).add(session);
			} catch (NumberFormatException e) {
				// list 등 숫자가 아닌 경우 무시
			}
		}
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

			broadcastToRoom(roomNum, dto);
			return;
		}

		// =========================
		// 🔥 MESSAGE 이벤트
		// =========================
		dto.setSenderNum(loginUser.getMemberNum());
		dto.setSenderName(loginUser.getMemberId());
		dto.setCreatetime(LocalDateTime.now());

		// 상대방이 방에 있는지 확인
		boolean isOtherInRoom = false;
		List<WebSocketSession> roomSess = roomSessions.get(roomNum);
		if (roomSess != null) {
			for (WebSocketSession s : roomSess) {
				MemberDTO user = (MemberDTO) ((Authentication) s.getPrincipal()).getPrincipal();
				if (!user.getMemberNum().equals(loginUser.getMemberNum())) {
					isOtherInRoom = true;
					break;
				}
			}
		}
		dto.setIsRead(isOtherInRoom);

		chatService.addMessage(dto);

		// 방 참여자 정보 조회
		ChatRoomDTO room = chatService.findById(roomNum);
		if (room != null) {
			
			// 알림 등록 (상대방에게만, 방에 없을 때)
			if (!isOtherInRoom) {
				Long recipientNum = (room.getBuyerNum().equals(loginUser.getMemberNum())) ? room.getSellerNum() : room.getBuyerNum();
				com.club.app.notification.NotificationDTO noti = new com.club.app.notification.NotificationDTO();
				noti.setMemberNum(recipientNum);
				noti.setNotificationContents(loginUser.getMemberId() + "님으로부터 새 메시지가 도착했습니다.");
				noti.setNotificationUrl("/productChat/detail?chatroomNum=" + roomNum);
				notificationService.add(noti);

				// 실시간 알림 전송 (타입: notification)
				ChatMessageDTO notiEvent = new ChatMessageDTO();
				notiEvent.setType("notification");
				notiEvent.setMessageContent(loginUser.getMemberId() + "님으로부터 새 메시지가 도착했습니다.");
				broadcastToUser(recipientNum, notiEvent);
			}

			// 발신자 & 수신자 모두에게 전송 (목록 업데이트 포함)
			broadcastToUser(room.getBuyerNum(), dto);
			broadcastToUser(room.getSellerNum(), dto);
		}
	}

	private void broadcastToRoom(Long roomNum, ChatMessageDTO dto) throws Exception {
		List<WebSocketSession> sessions = roomSessions.get(roomNum);
		if (sessions != null) {
			String json = objectMapper.writeValueAsString(dto);
			for (WebSocketSession s : sessions) {
				if (s.isOpen()) {
					s.sendMessage(new TextMessage(json));
				}
			}
		}
	}

	private void broadcastToUser(Long memberNum, ChatMessageDTO dto) throws Exception {
		List<WebSocketSession> sessions = userSessions.get(memberNum);
		if (sessions != null) {
			String json = objectMapper.writeValueAsString(dto);
			for (WebSocketSession s : sessions) {
				if (s.isOpen()) {
					s.sendMessage(new TextMessage(json));
				}
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {

		Authentication auth = (Authentication) session.getPrincipal();
		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();
		Long memberNum = loginUser.getMemberNum();

		// 사용자 세션 제거
		List<WebSocketSession> uSessions = userSessions.get(memberNum);
		if (uSessions != null) {
			uSessions.remove(session);
			if (uSessions.isEmpty())
				userSessions.remove(memberNum);
		}

		// 방 세션 제거
		String chatroomNumStr = (String) session.getAttributes().get("chatroomNum");
		if (chatroomNumStr != null && !chatroomNumStr.equals("list")) {
			try {
				Long chatroomNum = Long.valueOf(chatroomNumStr);
				List<WebSocketSession> rSessions = roomSessions.get(chatroomNum);
				if (rSessions != null) {
					rSessions.remove(session);
					if (rSessions.isEmpty())
						roomSessions.remove(chatroomNum);
				}
			} catch (NumberFormatException e) {
			}
		}
	}
}