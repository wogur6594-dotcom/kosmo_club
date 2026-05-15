package com.club.app.notification;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {

	private final NotificationMapper notificationMapper;

	// 알림 등록
	public int add(NotificationDTO notificationDTO) throws Exception {
		return notificationMapper.add(notificationDTO);
	}

	// 내 알림 목록
	public List<NotificationDTO> list(Long memberNum) throws Exception {
		return notificationMapper.list(memberNum);
	}

	// 안 읽은 알림 개수
	public Long unreadCount(Long memberNum) throws Exception {
		return notificationMapper.unreadCount(memberNum);
	}

	// 읽음 처리
	public int readUpdate(Long notificationNum) throws Exception {
		return notificationMapper.readUpdate(notificationNum);
	}

	public List<NotificationDTO> recentList(Long memberNum) throws Exception {

		return notificationMapper.recentList(memberNum);

	}
}