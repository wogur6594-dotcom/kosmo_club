package com.club.app.club.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.ClubService;
import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberService;
import com.club.app.member.MemberDTO;
import com.club.app.pager.Pager;

@Controller
@RequestMapping("/clubboard/*")
public class ClubBoardController {

	@Autowired
	private ClubFileService clubFileService;

	@PostMapping("mainImage")
	public String mainImage(Long fileNum, Long boardNum, Long clubNum) throws Exception {

		clubFileService.changeMainImage(boardNum, fileNum);

		return "redirect:./update?boardNum=" + boardNum + "&clubNum=" + clubNum;
	}

	@Autowired
	private ClubMemberService clubMemberService;

	@Autowired
	private ClubBoardService clubBoardService;

	@GetMapping("list")
	public String list(Pager pager, Model model) throws Exception {
		model.addAttribute("list", clubBoardService.clubBoardList(pager));
		model.addAttribute("pager", pager);

		return "clubboard/list";
	}

	@GetMapping("detail")
	public String detail(ClubBoardDTO clubBoardDTO, Pager pager, Model model) throws Exception {

		pager.setClubNum(clubBoardDTO.getClubNum());

		// 강제 지정
		if (pager.getPage() == null || pager.getPage() < 1) {
			pager.setPage(1L);
		}

		pager.setPerPage(5L);

		model.addAttribute("dto", clubBoardService.detail(clubBoardDTO));

		model.addAttribute("boardList", clubBoardService.clubBoardList(pager));

		model.addAttribute("pager", pager);

		return "clubboard/detail";
	}

	@GetMapping("create")
	public String create(ClubBoardDTO clubBoardDTO, Model model, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes rttr) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubBoardDTO.getClubNum());
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int check = clubMemberService.checkJoin(clubMemberDTO);

		if (check == 0) {
			rttr.addFlashAttribute("msg", "동호회 멤버가 아닙니다.");
			return "redirect:/club/detail?clubNum=" + clubBoardDTO.getClubNum();
		}

		model.addAttribute("dto", clubBoardDTO);
		return "clubboard/create";
	}

	@PostMapping("create")
	public String create(ClubBoardDTO clubBoardDTO, @AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		clubBoardDTO.setBoardWriter(memberDTO.getMemberId());

		clubBoardService.create(clubBoardDTO);

		return "redirect:./detail?boardNum=" + clubBoardDTO.getBoardNum() + "&clubNum=" + clubBoardDTO.getClubNum();
	}

	@GetMapping("update")
	public String update(ClubBoardDTO clubBoardDTO, Model model, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubBoardDTO dto = clubBoardService.detail(clubBoardDTO);

		if (!memberDTO.getMemberId().equals(dto.getBoardWriter())) {
			return "redirect:/clubboard/detail?boardNum=" + clubBoardDTO.getBoardNum() + "&clubNum="
					+ clubBoardDTO.getClubNum();
		}

		model.addAttribute("dto", dto);

		return "clubboard/update";
	}

	@PostMapping("update")
	public String update(ClubBoardDTO clubBoardDTO, @AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubBoardDTO checkDTO = clubBoardService.detail(clubBoardDTO);

		if (!memberDTO.getMemberId().equals(checkDTO.getBoardWriter())) {

			return "redirect:/clubboard/detail?boardNum=" + clubBoardDTO.getBoardNum() + "&clubNum="
					+ clubBoardDTO.getClubNum();
		}

		clubBoardService.update(clubBoardDTO);

		return "redirect:/clubboard/detail?boardNum=" + clubBoardDTO.getBoardNum() + "&clubNum="
				+ clubBoardDTO.getClubNum();
	}

	@PostMapping("delete")
	public String delete(ClubBoardDTO clubBoardDTO, @AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubBoardDTO checkDTO = clubBoardService.detail(clubBoardDTO);

		if (!memberDTO.getMemberId().equals(checkDTO.getBoardWriter()) && memberDTO.getRoleNum() != 1) {

			return "redirect:/clubboard/detail?boardNum=" + clubBoardDTO.getBoardNum() + "&clubNum="
					+ clubBoardDTO.getClubNum();
		}

		clubBoardService.delete(clubBoardDTO);

		return "redirect:/club/detail?clubNum=" + clubBoardDTO.getClubNum();
	}

}