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

			if (authentication == null) {
				return 0L;
			}

			Object principal = authentication.getPrincipal();

			if (!(principal instanceof MemberDTO)) {
				return 0L;
			}

			MemberDTO memberDTO = (MemberDTO) principal;

			return notificationService.unreadCount(memberDTO.getMemberNum());

		} catch (Exception e) {

			e.printStackTrace();

			return 0L;
		}
	}

	@ModelAttribute("recentNotifications")
	public List<NotificationDTO> recentNotifications() {

		try {

			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

			if (authentication == null) {
				return null;
			}

			Object principal = authentication.getPrincipal();

			if (!(principal instanceof MemberDTO)) {
				return null;
			}

			MemberDTO memberDTO = (MemberDTO) principal;

			return notificationService.recentList(memberDTO.getMemberNum());

		} catch (Exception e) {

			e.printStackTrace();

			return null;
		}
	}
}