package com.club.app.club.schedule;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.club.app.club.schedule.member.ClubScheduleMemberDTO;
import com.club.app.club.schedule.member.ClubScheduleMemberService;
import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/clubSchedule")
@RequiredArgsConstructor
public class ClubScheduleController {

	private final ClubScheduleService clubScheduleService;

	private final ClubScheduleMemberService clubScheduleMemberService;

	@GetMapping("/create")
	public String create(ClubScheduleDTO clubScheduleDTO, Model model) {

		model.addAttribute("clubNum", clubScheduleDTO.getClubNum());

		return "clubSchedule/create";
	}

	@PostMapping("/create")
	public String create(ClubScheduleDTO clubScheduleDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubScheduleDTO.setMemberNum(memberDTO.getMemberNum());

		clubScheduleService.create(clubScheduleDTO);

		return "redirect:/club/detail?clubNum=" + clubScheduleDTO.getClubNum();
	}

	@GetMapping("/list")
	public String list(ClubScheduleDTO clubScheduleDTO, Model model) throws Exception {

		model.addAttribute("scheduleList", clubScheduleService.list(clubScheduleDTO.getClubNum()));

		model.addAttribute("clubNum", clubScheduleDTO.getClubNum());

		return "clubSchedule/list";
	}

	@GetMapping("/detail")
	public String detail(ClubScheduleDTO clubScheduleDTO, Model model, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		clubScheduleDTO = clubScheduleService.detail(clubScheduleDTO);

		model.addAttribute("dto", clubScheduleDTO);

		boolean canEdit = false;

		if (memberDTO != null && clubScheduleDTO.getMemberNum().equals(memberDTO.getMemberNum())) {

			canEdit = true;
		}

		model.addAttribute("canEdit", canEdit);

		model.addAttribute("joinCount", clubScheduleMemberService.count(clubScheduleDTO.getScheduleNum()));

		// 로그인 상태일 때 참가 여부 확인
		if (memberDTO != null) {

			ClubScheduleMemberDTO clubScheduleMemberDTO = new ClubScheduleMemberDTO();

			clubScheduleMemberDTO.setScheduleNum(clubScheduleDTO.getScheduleNum());

			clubScheduleMemberDTO.setMemberNum(memberDTO.getMemberNum());

			Long isJoin = clubScheduleMemberService.isJoin(clubScheduleMemberDTO);

			model.addAttribute("isJoin", isJoin);
		}

		return "clubSchedule/detail";
	}

	@PostMapping("/delete")
	public String delete(ClubScheduleDTO clubScheduleDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubScheduleDTO check = clubScheduleService.detail(clubScheduleDTO);

		if (!check.getMemberNum().equals(memberDTO.getMemberNum())) {

			return "redirect:/clubSchedule/detail?scheduleNum=" + clubScheduleDTO.getScheduleNum();
		}

		clubScheduleService.delete(clubScheduleDTO);

		return "redirect:/club/detail?clubNum=" + check.getClubNum();
	}
}