package com.club.app.club.schedule.member;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberService;
import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/clubScheduleMember/*")
public class ClubScheduleMemberController {

	private final ClubScheduleMemberService clubScheduleMemberService;

	private final ClubMemberService clubMemberService;

	@PostMapping("join")
	public String join(ClubScheduleMemberDTO clubScheduleMemberDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubScheduleMemberDTO.setMemberNum(memberDTO.getMemberNum());

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubScheduleMemberDTO.getClubNum());
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int isClubMember = clubMemberService.checkJoin(clubMemberDTO);

		if (isClubMember == 0) {
			redirectAttributes.addFlashAttribute("msg", "동호회 회원만 일정에 참가할 수 있습니다.");

			return "redirect:/clubSchedule/detail?scheduleNum=" + clubScheduleMemberDTO.getScheduleNum();
		}

		int result = clubScheduleMemberService.join(clubScheduleMemberDTO);

		if (result == 0) {
			redirectAttributes.addFlashAttribute("msg", "이미 참가한 일정입니다.");
		} else {
			redirectAttributes.addFlashAttribute("msg", "일정 참가가 완료되었습니다.");
		}

		return "redirect:/clubSchedule/detail?scheduleNum=" + clubScheduleMemberDTO.getScheduleNum();
	}

	@PostMapping("cancel")
	public String cancel(ClubScheduleMemberDTO clubScheduleMemberDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubScheduleMemberDTO.setMemberNum(memberDTO.getMemberNum());

		clubScheduleMemberService.cancel(clubScheduleMemberDTO);

		redirectAttributes.addFlashAttribute("msg", "일정 참가가 취소되었습니다.");

		return "redirect:/clubSchedule/detail?scheduleNum=" + clubScheduleMemberDTO.getScheduleNum();
	}
}