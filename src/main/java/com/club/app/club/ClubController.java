package com.club.app.club;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.club.app.pager.Pager;

@Controller
@RequestMapping("/club/*")
public class ClubController {

	@Autowired
	private ClubService clubService;

	@GetMapping("list")
	public String list(Pager pager, Model model) throws Exception {

		List<ClubDTO> ar = clubService.list(pager);

		model.addAttribute("list", ar);
		model.addAttribute("pager", pager);

		return "club/list";

	}

	@GetMapping("detail")
	public void detail(ClubDTO clubDTO, Model model) throws Exception {

		clubDTO = clubService.detail(clubDTO);

		model.addAttribute("dto", clubDTO);
	}

	@GetMapping("create")
	public String create() throws Exception {

		return "club/create";

	}

	@PostMapping("create")
	public String create(ClubDTO clubDTO, Model model) throws Exception {

		int result = clubService.create(clubDTO);

		return "club/list";

	}

}
