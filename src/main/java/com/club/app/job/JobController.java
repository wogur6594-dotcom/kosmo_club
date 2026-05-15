package com.club.app.job;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/job/*")
public class JobController {

	private final JobService jobService;

	@GetMapping("list")
	public String list(JobPager jobPager, Model model) throws Exception {

		List<JobDTO> list = jobService.list(jobPager);

		List<String> categoryList = List.of("서빙", "주방보조", "편의점", "매장관리", "음료 제조", "베이킹", "집옮기기", "청소", "과외");

		List<String> typeList = List.of("단기", "1개월 이상");

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("typeList", typeList);

		model.addAttribute("list", list);
		model.addAttribute("pager", jobPager);

		return "job/list";
	}

	@GetMapping("create")
	public String create() {
		return "job/create";
	}

	@PostMapping("create")
	public String create(JobDTO jobDTO, Authentication authentication) throws Exception {

		MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

		jobDTO.setMemberNum(memberDTO.getMemberNum());

		jobService.add(jobDTO);

		return "redirect:./list";
	}

	@GetMapping("detail")
	public String detail(JobDTO jobDTO, Model model) throws Exception {

		jobDTO = jobService.detail(jobDTO);

		model.addAttribute("dto", jobDTO);

		return "job/detail";
	}

	@GetMapping("update")
	public String update(JobDTO jobDTO, Model model, Authentication authentication) throws Exception {

		MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

		jobDTO = jobService.detail(jobDTO);

		if (!jobDTO.getMemberNum().equals(memberDTO.getMemberNum())) {
			return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
		}

		model.addAttribute("dto", jobDTO);

		return "job/update";
	}

	@PostMapping("update")
	public String update(JobDTO jobDTO, Authentication authentication) throws Exception {

		MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

		jobDTO.setMemberNum(memberDTO.getMemberNum());

		jobService.update(jobDTO);

		return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
	}

	@PostMapping("delete")
	public String delete(JobDTO jobDTO, Authentication authentication) throws Exception {

		MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

		jobService.delete(jobDTO, memberDTO);

		return "redirect:./list";
	}
}