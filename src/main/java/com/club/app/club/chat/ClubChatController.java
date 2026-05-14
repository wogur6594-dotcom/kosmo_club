package com.club.app.club.chat;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberService;
import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/clubChat/*")
public class ClubChatController {

	private final ClubMemberService clubMemberService;
	private final ClubMessageService clubMessageService;

	@GetMapping("room")
	public String room(@RequestParam("clubNum") Long clubNum,
			@AuthenticationPrincipal MemberDTO memberDTO,
			Model model,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubNum);
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int check = clubMemberService.checkJoin(clubMemberDTO);

		if (check == 0) {
			redirectAttributes.addFlashAttribute("msg", "동호회 가입 회원만 채팅을 사용할 수 있습니다.");
			return "redirect:/club/detail?clubNum=" + clubNum;
		}

		model.addAttribute("clubNum", clubNum);
		model.addAttribute("messageList", clubMessageService.list(clubNum));

		return "clubChat/room";
	}
}