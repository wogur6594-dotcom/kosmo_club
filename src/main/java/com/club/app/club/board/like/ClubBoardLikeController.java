package com.club.app.club.board.like;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/clubboard/like/*")
public class ClubBoardLikeController {

	private final ClubBoardLikeService clubBoardLikeService;

	@PostMapping("add")
	public String add(ClubBoardLikeDTO clubBoardLikeDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubBoardLikeDTO.setMemberNum(memberDTO.getMemberNum());

		clubBoardLikeService.add(clubBoardLikeDTO);

		return "redirect:/clubboard/detail?boardNum=" + clubBoardLikeDTO.getBoardNum();
	}

	@PostMapping("delete")
	public String delete(ClubBoardLikeDTO clubBoardLikeDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		clubBoardLikeDTO.setMemberNum(memberDTO.getMemberNum());

		clubBoardLikeService.delete(clubBoardLikeDTO);

		return "redirect:/clubboard/detail?boardNum=" + clubBoardLikeDTO.getBoardNum();
	}
}