package com.club.app.notification;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@ControllerAdvice
@RequiredArgsConstructor
public class NotificationAdvice {

	private final NotificationService notificationService;

	@ModelAttribute("notificationCount")
	public Long notificationCount() {

		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

			System.out.println("=== NotificationAdvice count 실행 ===");
			System.out.println("authentication = " + authentication);

			if (authentication == null) {
				System.out.println("authentication null");
				return 0L;
			}

			Object principal = authentication.getPrincipal();

			System.out.println("principal = " + principal);
			System.out.println("principal class = " + principal.getClass());

			if (!(principal instanceof MemberDTO)) {
				System.out.println("principal 이 MemberDTO 아님");
				return 0L;
			}

			MemberDTO memberDTO = (MemberDTO) principal;

			Long count = notificationService.unreadCount(memberDTO.getMemberNum());

			System.out.println("알림 개수 = " + count);

			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return 0L;
		}
	}

	@ModelAttribute("recentNotifications")
	public List<NotificationDTO> recentNotifications() {

		try {
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

			System.out.println("=== NotificationAdvice list 실행 ===");
			System.out.println("authentication = " + authentication);

			if (authentication == null) {
				System.out.println("authentication null");
				return null;
			}

			Object principal = authentication.getPrincipal();

			System.out.println("principal = " + principal);
			System.out.println("principal class = " + principal.getClass());

			if (!(principal instanceof MemberDTO)) {
				System.out.println("principal 이 MemberDTO 아님");
				return null;
			}

			MemberDTO memberDTO = (MemberDTO) principal;

			List<NotificationDTO> list = notificationService.recentList(memberDTO.getMemberNum());

			System.out.println("최근 알림 개수 = " + list.size());

			return list;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}