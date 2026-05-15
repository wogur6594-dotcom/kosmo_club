package com.club.app.club.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.ClubDTO;
import com.club.app.club.ClubService;
import com.club.app.member.MemberDTO;

@Controller
@RequestMapping("/clubMember/*")
public class ClubMemberController {

	@Autowired
	private ClubService clubService;

	@Autowired
	private ClubMemberService clubMemberService;

	@PostMapping("join")
	public String join(ClubMemberDTO clubMemberDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());
		clubMemberDTO.setRoleNum(0L);

		int result = clubMemberService.join(clubMemberDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "가입 신청이 완료되었습니다.");
		} else if (result == -1) {
			redirectAttributes.addFlashAttribute("message", "정원이 초과되어 가입할 수 없습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "이미 가입한 동호회입니다.");
		}

		return "redirect:/club/detail?clubNum=" + clubMemberDTO.getClubNum();
	}

	@GetMapping("waitList")
	public String waitList(@RequestParam("clubNum") Long clubNum, Model model) throws Exception {

		List<ClubMemberDTO> list = clubMemberService.waitList(clubNum);

		model.addAttribute("list", list);
		model.addAttribute("clubNum", clubNum);

		return "clubMember/waitList";
	}

	@PostMapping("approve")
	public String approve(ClubMemberDTO clubMemberDTO, RedirectAttributes redirectAttributes) throws Exception {

		int result = clubMemberService.approve(clubMemberDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "가입을 승인했습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "가입 승인에 실패했습니다.");
		}

		return "redirect:/clubMember/waitList?clubNum=" + clubMemberDTO.getClubNum();
	}

	@PostMapping("kick")
	public String kickMember(ClubMemberDTO clubMemberDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		ClubDTO checkDTO = new ClubDTO();
		checkDTO.setClubNum(clubMemberDTO.getClubNum());
		checkDTO.setMemberNum(memberDTO.getMemberNum());

		Long ownerCheck = clubService.isClubOwner(checkDTO);

		if (ownerCheck == 0) {
			redirectAttributes.addFlashAttribute("message", "강퇴 권한이 없습니다.");
			return "redirect:/club/detail?clubNum=" + clubMemberDTO.getClubNum();
		}

		clubMemberService.kickMember(clubMemberDTO);

		redirectAttributes.addFlashAttribute("message", "회원이 강퇴되었습니다.");

		return "redirect:/clubMember/memberList?clubNum=" + clubMemberDTO.getClubNum();
	}

	@GetMapping("memberList")
	public String memberList(@RequestParam("clubNum") Long clubNum, Model model) throws Exception {

		model.addAttribute("list", clubMemberService.memberList(clubNum));
		model.addAttribute("clubNum", clubNum);

		return "clubMember/memberList";
	}

	@PostMapping("leave")
	public String leave(ClubMemberDTO clubMemberDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int result = clubMemberService.leave(clubMemberDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "동호회에서 탈퇴했습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "회장은 탈퇴할 수 없습니다.");
		}

		return "redirect:/club/detail?clubNum=" + clubMemberDTO.getClubNum();
	}

	@PostMapping("delegateOwner")
	public String delegateOwner(ClubMemberDTO clubMemberDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		ClubDTO checkDTO = new ClubDTO();

		checkDTO.setClubNum(clubMemberDTO.getClubNum());
		checkDTO.setMemberNum(memberDTO.getMemberNum());

		Long ownerCheck = clubService.isClubOwner(checkDTO);

		if (ownerCheck == 0) {

			redirectAttributes.addFlashAttribute("message", "회장만 권한 위임이 가능합니다.");

			return "redirect:/club/detail?clubNum=" + clubMemberDTO.getClubNum();
		}

		clubMemberService.delegateOwner(clubMemberDTO);

		redirectAttributes.addFlashAttribute("message", "회장이 변경되었습니다.");

		return "redirect:/club/detail?clubNum=" + clubMemberDTO.getClubNum();
	}

}