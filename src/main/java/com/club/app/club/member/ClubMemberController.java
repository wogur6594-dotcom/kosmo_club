package com.club.app.club.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.member.MemberDTO;

@Controller
@RequestMapping("/clubMember/*")
public class ClubMemberController {

	@Autowired
	private ClubMemberService clubMemberService;

	@PostMapping("join")
	public String join(ClubMemberDTO clubMemberDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());
		clubMemberDTO.setRoleNum(2L);

		int result = clubMemberService.join(clubMemberDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "가입이 완료되었습니다.");
		} else if (result == -1) {
			redirectAttributes.addFlashAttribute("message", "정원이 초과되어 가입할 수 없습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "이미 가입한 동호회입니다.");
		}

		return "redirect:/club/detail?clubNum=" + clubMemberDTO.getClubNum();
	}

}