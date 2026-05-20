package com.club.app.notification;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.member.MemberDTO;
import com.club.app.productChat.ChatService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notification/*")
public class NotificationController {

	private final NotificationService notificationService;
	private final ChatService chatService;

	@GetMapping("list")
	public String list(@AuthenticationPrincipal MemberDTO memberDTO, Model model) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		List<NotificationDTO> list = notificationService.list(memberDTO.getMemberNum());

		model.addAttribute("list", list);

		return "notification/list";
	}

	@GetMapping("read")
	public String read(@RequestParam("notificationNum") Long notificationNum,
			@RequestParam(value = "url", required = false) String url, RedirectAttributes redirectAttributes)
			throws Exception {

		notificationService.readUpdate(notificationNum);

		if (url != null && !url.contains("chatroomNum")) {
			return "redirect:" + url;
		} else if (url != null && url.contains("chatroomNum")) {
			// 채팅방 존재 여부 확인
			String numStr = url.split("chatroomNum=")[1];
			Long chatroomNum = Long.parseLong(numStr);

			if (chatService.findById(chatroomNum) == null) {
				redirectAttributes.addFlashAttribute("msg", "삭제된 채팅방입니다.");
				return "redirect:/productChat/list";
			}
			return "redirect:" + url;
		}

		return "redirect:/notification/list";
	}
}
