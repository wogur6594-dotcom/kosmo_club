package com.club.app.club.board.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberService;
import com.club.app.member.MemberDTO;

@Controller
public class ClubBoardCommentController {
	
	@Autowired
	private ClubMemberService clubMemberService;

	@Autowired
	private ClubBoardCommentService clubBoardCommentService;

	@PostMapping("/clubboardcomment/add")
	public String add(ClubBoardCommentDTO clubBoardCommentDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			@RequestParam("clubNum") Long clubNum, RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubNum);
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int check = clubMemberService.checkJoin(clubMemberDTO);

		if (check == 0) {
			redirectAttributes.addFlashAttribute("message", "동호회 멤버만 댓글을 작성할 수 있습니다.");

			return "redirect:/clubboard/detail?boardNum=" + clubBoardCommentDTO.getBoardNum() + "&clubNum=" + clubNum;
		}

		clubBoardCommentDTO.setMemberNum(memberDTO.getMemberNum());

		int result = clubBoardCommentService.add(clubBoardCommentDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "댓글이 등록되었습니다.");
		}

		return "redirect:/clubboard/detail?boardNum=" + clubBoardCommentDTO.getBoardNum() + "&clubNum=" + clubNum;
	}

}