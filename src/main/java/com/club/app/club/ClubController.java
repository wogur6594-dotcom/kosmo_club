package com.club.app.club;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.board.ClubBoardService;
import com.club.app.member.MemberDTO;
import com.club.app.pager.Pager;

@Controller
@RequestMapping("/club/*")
public class ClubController {

	@Autowired
	private ClubService clubService;

	@GetMapping("list")
	public String list(Pager pager, Model model) throws Exception {

		List<ClubDTO> list = clubService.list(pager);

		model.addAttribute("list", list);
		model.addAttribute("pager", pager);

		return "club/list";
	}

	@Autowired
	private ClubBoardService clubBoardService;

	@GetMapping("detail")
	public void detail(ClubDTO clubDTO, Pager pager, Model model) throws Exception {

		clubDTO = clubService.detail(clubDTO);

		pager.setClubNum(clubDTO.getClubNum());
		pager.setPerPage(6L);

		model.addAttribute("dto", clubDTO);

		model.addAttribute("boardList", clubBoardService.clubBoardList(pager));

		model.addAttribute("pager", pager);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		boolean canDelete = false;

		if (authentication != null && authentication.isAuthenticated()
				&& !authentication.getPrincipal().equals("anonymousUser")) {

			MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

			ClubDTO checkDTO = new ClubDTO();
			checkDTO.setClubNum(clubDTO.getClubNum());
			checkDTO.setMemberNum(memberDTO.getMemberNum());

			Long ownerCheck = clubService.isClubOwner(checkDTO);
			Long adminCheck = clubService.isAdmin(memberDTO);

			canDelete = ownerCheck > 0 || adminCheck > 0;
		}

		model.addAttribute("canDelete", canDelete);
	}

	@GetMapping("create")
	public String create(@AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

	    if (memberDTO == null) {
	        return "redirect:/member/login";
	    }

	    return "club/create";
	}

	@PostMapping("create")
	public String create(
	        ClubDTO clubDTO,
	        @RequestParam("attach") MultipartFile[] attaches,
	        @AuthenticationPrincipal MemberDTO memberDTO
	        ) throws Exception {

	    if (memberDTO == null) {
	        return "redirect:/member/login";
	    }

	    clubService.create(clubDTO, attaches, memberDTO);

	    return "redirect:/club/list";
	}
	
	@PostMapping("delete")
	public String delete(ClubDTO clubDTO, RedirectAttributes redirectAttributes) throws Exception {

		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication == null || authentication.getPrincipal().equals("anonymousUser")) {
			return "redirect:/member/login";
		}

		MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

		ClubDTO checkDTO = new ClubDTO();
		checkDTO.setClubNum(clubDTO.getClubNum());
		checkDTO.setMemberNum(memberDTO.getMemberNum());

		Long ownerCheck = clubService.isClubOwner(checkDTO);
		Long adminCheck = clubService.isAdmin(memberDTO);

		if (ownerCheck == 0 && adminCheck == 0) {
			redirectAttributes.addFlashAttribute("msg", "삭제 권한이 없습니다.");
			return "redirect:./detail?clubNum=" + clubDTO.getClubNum();
		}

		clubService.delete(clubDTO);

		redirectAttributes.addFlashAttribute("msg", "동호회가 삭제되었습니다.");
		return "redirect:./list";
	}


}
