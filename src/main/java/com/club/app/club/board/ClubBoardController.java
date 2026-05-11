package com.club.app.club.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.club.app.pager.Pager;

@Controller
public class ClubBoardController {

    @Autowired
    private ClubBoardService clubBoardService;

    @GetMapping("/clubBoard/list")
    public String list(Pager pager, Model model) throws Exception {
        model.addAttribute("list", clubBoardService.list(pager));
        model.addAttribute("pager", pager);

        return "clubBoard/list";
    }

    @GetMapping("/clubBoard/detail")
    public String detail(ClubBoardDTO clubBoardDTO, Model model) throws Exception {
        model.addAttribute("dto", clubBoardService.detail(clubBoardDTO));

        return "clubBoard/detail";
    }
}