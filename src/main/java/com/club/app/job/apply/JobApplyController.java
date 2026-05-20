package com.club.app.job.apply;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/jobApply/*")
public class JobApplyController {

	private final JobApplyService jobApplyService;

	@PostMapping("apply")
	public String apply(JobApplyDTO jobApplyDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobApplyDTO.setMemberNum(memberDTO.getMemberNum());

		int result = jobApplyService.apply(jobApplyDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "지원이 완료되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "이미 지원한 공고입니다.");
		}

		return "redirect:/job/detail?jobNum=" + jobApplyDTO.getJobNum();
	}

	@PostMapping("cancel")
	public String cancel(JobApplyDTO jobApplyDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobApplyDTO.setMemberNum(memberDTO.getMemberNum());

		int result = jobApplyService.cancel(jobApplyDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "지원이 취소되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "대기중인 지원만 취소할 수 있습니다.");
		}

		return "redirect:/job/detail?jobNum=" + jobApplyDTO.getJobNum();
	}

	@PostMapping("status")
	public String status(JobApplyDTO jobApplyDTO, RedirectAttributes redirectAttributes) throws Exception {

		int result = jobApplyService.updateStatus(jobApplyDTO);

		if (result == -1) {
			redirectAttributes.addFlashAttribute("message", "이미 모집이 완료된 공고입니다.");
		} else if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "지원 상태가 변경되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "지원 상태 변경에 실패했습니다.");
		}

		return "redirect:/jobApply/applicantList?jobNum=" + jobApplyDTO.getJobNum();
	}

	@GetMapping("applicantList")
	public String applicantList(JobApplyDTO jobApplyDTO, Model model) throws Exception {

		model.addAttribute("list", jobApplyService.applicantList(jobApplyDTO));

		model.addAttribute("jobNum", jobApplyDTO.getJobNum());

		return "jobApply/applicantList";
	}

	@GetMapping("myList")
	public String myList(@AuthenticationPrincipal MemberDTO memberDTO, JobApplyDTO jobApplyDTO, Model model)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobApplyDTO.setMemberNum(memberDTO.getMemberNum());

		model.addAttribute("list", jobApplyService.myApplyList(jobApplyDTO));

		return "jobApply/myList";
	}

}