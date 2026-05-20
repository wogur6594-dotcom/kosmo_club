package com.club.app.job;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String create(@AuthenticationPrincipal MemberDTO memberDTO) {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		return "job/create";
	}

	@PostMapping("create")
	public String create(JobDTO jobDTO, @AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobDTO.setMemberNum(memberDTO.getMemberNum());
		jobService.add(jobDTO);

		return "redirect:./list";
	}

	@GetMapping("detail")
	public String detail(JobDTO jobDTO, Model model, @AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		jobDTO = jobService.detail(jobDTO);

		if (jobDTO == null) {
			return "redirect:./list";
		}

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
	public String update(JobDTO jobDTO, Model model, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobDTO = jobService.detail(jobDTO);

		if (jobDTO == null) {
			redirectAttributes.addFlashAttribute("message", "존재하지 않는 공고입니다.");
			return "redirect:./list";
		}

		if (!jobDTO.getMemberNum().equals(memberDTO.getMemberNum())) {
			redirectAttributes.addFlashAttribute("message", "공고 작성자만 수정할 수 있습니다.");
			return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
		}

		model.addAttribute("dto", jobDTO);

		return "job/update";
	}

	@PostMapping("update")
	public String update(JobDTO jobDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		JobDTO origin = new JobDTO();
		origin.setJobNum(jobDTO.getJobNum());
		origin = jobService.detail(origin);

		if (origin == null) {
			redirectAttributes.addFlashAttribute("message", "존재하지 않는 공고입니다.");
			return "redirect:./list";
		}

		if (!origin.getMemberNum().equals(memberDTO.getMemberNum())) {
			redirectAttributes.addFlashAttribute("message", "공고 작성자만 수정할 수 있습니다.");
			return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
		}

		jobDTO.setMemberNum(memberDTO.getMemberNum());

		int result = jobService.update(jobDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "공고가 수정되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "공고 수정에 실패했습니다.");
		}

		return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
	}

	@PostMapping("delete")
	public String delete(JobDTO jobDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		JobDTO origin = new JobDTO();
		origin.setJobNum(jobDTO.getJobNum());
		origin = jobService.detail(origin);

		if (origin == null) {
			redirectAttributes.addFlashAttribute("message", "존재하지 않는 공고입니다.");
			return "redirect:./list";
		}

		boolean isAdmin = memberDTO.getAuthorities().stream()
				.anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));

		if (!isAdmin && !origin.getMemberNum().equals(memberDTO.getMemberNum())) {
			redirectAttributes.addFlashAttribute("message", "공고 작성자만 삭제할 수 있습니다.");
			return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
		}

		jobService.delete(jobDTO, memberDTO);

		redirectAttributes.addFlashAttribute("message", "공고가 삭제되었습니다.");

		return "redirect:./list";
	}

	@PostMapping("deleteFile")
	public String deleteFile(JobDTO jobDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		JobDTO origin = new JobDTO();
		origin.setJobNum(jobDTO.getJobNum());
		origin = jobService.detail(origin);

		if (origin == null) {
			redirectAttributes.addFlashAttribute("message", "존재하지 않는 공고입니다.");
			return "redirect:./list";
		}

		if (!origin.getMemberNum().equals(memberDTO.getMemberNum())) {
			redirectAttributes.addFlashAttribute("message", "공고 작성자만 파일을 삭제할 수 있습니다.");
			return "redirect:./detail?jobNum=" + jobDTO.getJobNum();
		}

		jobService.deleteFile(jobDTO);

		redirectAttributes.addFlashAttribute("message", "첨부파일이 삭제되었습니다.");

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