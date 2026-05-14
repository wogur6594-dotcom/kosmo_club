package com.club.app.club.schedule;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberService;
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

	private final ClubMemberService clubMemberService;

	@GetMapping("/create")
	public String create(ClubScheduleDTO clubScheduleDTO, Model model,
			@AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubScheduleDTO.getClubNum());
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int check = clubMemberService.checkJoin(clubMemberDTO);

		if (check == 0) {
			return "redirect:/club/detail?clubNum=" + clubScheduleDTO.getClubNum() + "&message=scheduleMemberOnly";
		}

		model.addAttribute("clubNum", clubScheduleDTO.getClubNum());

		return "clubSchedule/create";
	}

	@PostMapping("/create")
	public String create(ClubScheduleDTO clubScheduleDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubScheduleDTO.getClubNum());
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int check = clubMemberService.checkJoin(clubMemberDTO);

		if (check == 0) {
			return "redirect:/club/detail?clubNum=" + clubScheduleDTO.getClubNum() + "&message=scheduleMemberOnly";
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

		model.addAttribute("memberList", clubScheduleMemberService.memberList(clubScheduleDTO.getScheduleNum()));

		if (memberDTO != null) {

			ClubScheduleMemberDTO clubScheduleMemberDTO = new ClubScheduleMemberDTO();

			clubScheduleMemberDTO.setScheduleNum(clubScheduleDTO.getScheduleNum());

			clubScheduleMemberDTO.setMemberNum(memberDTO.getMemberNum());

			Long isJoin = clubScheduleMemberService.isJoin(clubScheduleMemberDTO);

			model.addAttribute("isJoin", isJoin);
		}

		return "clubSchedule/detail";
	}

	@GetMapping("/update")
	public String update(ClubScheduleDTO clubScheduleDTO, @AuthenticationPrincipal MemberDTO memberDTO, Model model)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubScheduleDTO dto = clubScheduleService.detail(clubScheduleDTO);

		if (!dto.getMemberNum().equals(memberDTO.getMemberNum())) {
			return "redirect:/clubSchedule/detail?scheduleNum=" + clubScheduleDTO.getScheduleNum();
		}

		model.addAttribute("dto", dto);

		return "clubSchedule/update";
	}

	@PostMapping("/update")
	public String update(ClubScheduleDTO clubScheduleDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubScheduleDTO check = clubScheduleService.detail(clubScheduleDTO);

		if (!check.getMemberNum().equals(memberDTO.getMemberNum())) {
			return "redirect:/clubSchedule/detail?scheduleNum=" + clubScheduleDTO.getScheduleNum();
		}

		clubScheduleService.update(clubScheduleDTO);

		return "redirect:/clubSchedule/detail?scheduleNum=" + clubScheduleDTO.getScheduleNum();
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