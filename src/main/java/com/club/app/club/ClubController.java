package com.club.app.club;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.club.board.ClubBoardService;
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
	}

	@GetMapping("create")
	public String create() throws Exception {

		return "club/create";

	}

	@PostMapping("create")
	public String create(
	        ClubDTO clubDTO,
	        @RequestParam("attaches") MultipartFile[] attaches
	        ) throws Exception {

	    clubService.create(clubDTO, attaches);

	    return "redirect:/club/list";
	}
	
	
	//테스트


}
