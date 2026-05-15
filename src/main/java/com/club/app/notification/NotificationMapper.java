package com.club.app.notification;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NotificationMapper {

	// 알림 등록
	int add(NotificationDTO notificationDTO) throws Exception;

	// 내 알림 목록
	List<NotificationDTO> list(Long memberNum) throws Exception;

	// 안 읽은 알림 개수
	Long unreadCount(Long memberNum) throws Exception;

	// 알림 읽음 처리
	int readUpdate(Long notificationNum) throws Exception;
	
	List<NotificationDTO> recentList(Long memberNum) throws Exception;

}