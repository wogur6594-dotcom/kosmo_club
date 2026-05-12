package com.club.app.club.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.club.app.club.ClubService;
import com.club.app.pager.Pager;

@Controller
@RequestMapping("/clubboard/*")
public class ClubBoardController {

	@Autowired
	private ClubBoardService clubBoardService;

	@GetMapping("list")
	public String list(Pager pager, Model model) throws Exception {
		model.addAttribute("list", clubBoardService.list(pager));
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

		pager.setPerPage(6L);

		model.addAttribute("dto", clubBoardService.detail(clubBoardDTO));

		model.addAttribute("boardList", clubBoardService.clubBoardList(pager));

		model.addAttribute("pager", pager);

		return "clubboard/detail";
	}

	@GetMapping("create")
	public String create(ClubBoardDTO clubBoardDTO, Model model) {
		model.addAttribute("dto", clubBoardDTO);
		return "clubboard/create";
	}
	
	@PostMapping("create")
	public String create(ClubBoardDTO clubBoardDTO) throws Exception {

		clubBoardService.create(clubBoardDTO);

		return "redirect:./detail?boardNum=" + clubBoardDTO.getBoardNum()
				+ "&clubNum=" + clubBoardDTO.getClubNum();
	}

}