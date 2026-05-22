package com.club.app.productChat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatService {

	@Autowired
	private ChatMapper chatMapper;

	@Autowired
	private com.club.app.file.S3Service s3Service;

	// 채팅방 조회
	public ChatRoomDTO findRoom(ChatRoomDTO chatRoomDTO) throws Exception {
		return chatMapper.findRoom(chatRoomDTO);
	}

	// 채팅방 생성
	public ChatRoomDTO createRoom(ChatRoomDTO chatRoomDTO) throws Exception {
		chatMapper.createRoom(chatRoomDTO);
		return chatMapper.findById(chatRoomDTO.getChatroomNum());
	}

	// 내 채팅 목록
	public List<ChatRoomDTO> list(Long memberNum) throws Exception {
		return chatMapper.list(memberNum);
	}

	// 메시지 저장
	public int addMessage(ChatMessageDTO chatMessageDTO) throws Exception {
		return chatMapper.addMessage(chatMessageDTO);
	}

	// 메시지 목록
	public List<ChatMessageDTO> messageList(Long chatroomNum) throws Exception {
		return chatMapper.messageList(chatroomNum);
	}

	public ChatRoomDTO findById(Long chatroomNum) throws Exception {
		return chatMapper.findById(chatroomNum);
	}

	public int deleteChatRoom(Long chatroomNum) throws Exception {
		// 1. 채팅방의 모든 메시지 조회
		List<ChatMessageDTO> messages = chatMapper.messageList(chatroomNum);

		// 2. 이미지 타입의 메시지인 경우 S3에서 삭제
		for (ChatMessageDTO m : messages) {
			if ("image".equals(m.getType())) {
				s3Service.delete(m.getMessageContent());
			}
		}
		// 3. DB 삭제
		return chatMapper.deleteChatRoom(chatroomNum);
	}

	public int markAsRead(Long chatroomNum, Long memberNum) throws Exception {
		return chatMapper.markAsRead(chatroomNum, memberNum);
	}

	public int countByProductNum(Long productNum) throws Exception {
		return chatMapper.countByProductNum(productNum);
	}
}
