package com.club.app.job;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.club.app.job.apply.JobApplyDTO;
import com.club.app.job.apply.JobApplyService;
import com.club.app.job.bookmark.JobBookmarkDTO;
import com.club.app.job.bookmark.JobBookmarkService;
import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/job/*")
public class JobController {

	private final JobService jobService;

	private final JobApplyService jobApplyService;

	private final JobBookmarkService jobBookmarkService;

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
	public String detail(JobDTO jobDTO, Model model, @AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		jobDTO = jobService.detail(jobDTO);

		model.addAttribute("dto", jobDTO);

		boolean isApply = false;
		boolean isWriter = false;
		String applyStatus = null;
		int bookmarkCheck = 0;

		if (memberDTO != null) {
			JobApplyDTO jobApplyDTO = new JobApplyDTO();
			jobApplyDTO.setJobNum(jobDTO.getJobNum());
			jobApplyDTO.setMemberNum(memberDTO.getMemberNum());

			JobApplyDTO myApply = jobApplyService.myApplyStatus(jobApplyDTO);

			if (myApply != null) {
				isApply = true;
				applyStatus = myApply.getApplyStatus();
			}

			if (jobDTO.getMemberNum().equals(memberDTO.getMemberNum())) {
				isWriter = true;
			}

			JobBookmarkDTO jobBookmarkDTO = new JobBookmarkDTO();
			jobBookmarkDTO.setJobNum(jobDTO.getJobNum());
			jobBookmarkDTO.setMemberNum(memberDTO.getMemberNum());

			bookmarkCheck = jobBookmarkService.check(jobBookmarkDTO);
		}

		model.addAttribute("isApply", isApply);
		model.addAttribute("isWriter", isWriter);
		model.addAttribute("applyStatus", applyStatus);
		model.addAttribute("bookmarkCheck", bookmarkCheck);

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

	@PostMapping("deleteFile")
	public String deleteFile(JobDTO jobDTO, Authentication authentication) throws Exception {

		MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

		JobDTO origin = jobService.detail(jobDTO);

		if (!origin.getMemberNum().equals(memberDTO.getMemberNum())) {
			return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
		}

		jobService.deleteFile(jobDTO);

		return "redirect:./update?jobNum=" + jobDTO.getJobNum();
	}

	@GetMapping("myJobList")
	public String myJobList(@AuthenticationPrincipal MemberDTO memberDTO, JobDTO jobDTO, Model model) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobDTO.setMemberNum(memberDTO.getMemberNum());

		model.addAttribute("list", jobService.myJobList(jobDTO));

		return "job/myJobList";
	}

}