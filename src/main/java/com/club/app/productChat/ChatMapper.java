package com.club.app.productChat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ChatMapper {

	// 채팅방 조회
	public ChatRoomDTO findRoom(ChatRoomDTO chatRoomDTO) throws Exception;

	// 채팅방 생성
	public int createRoom(ChatRoomDTO chatRoomDTO) throws Exception;

	// 채팅방 번호 조회
	public ChatRoomDTO findById(Long chatroomNum) throws Exception;

	// 내 채팅 목록
	public List<ChatRoomDTO> list(Long memberNum) throws Exception;

	// 메시지 저장
	public int addMessage(ChatMessageDTO chatMessageDTO) throws Exception;

	// 메시지 목록
	public List<ChatMessageDTO> messageList(Long chatroomNum) throws Exception;

	public int deleteChatRoom(Long chatroomNum);

	public int markAsRead(@Param("chatroomNum") Long chatroomNum, @Param("memberNum") Long memberNum);

	public int countByProductNum(Long productNum) throws Exception;
}