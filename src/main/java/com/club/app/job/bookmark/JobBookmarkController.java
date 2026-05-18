package com.club.app.job.bookmark;

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
@RequestMapping("/jobBookmark/*")
public class JobBookmarkController {

	private final JobBookmarkService jobBookmarkService;

	@PostMapping("add")
	public String add(JobBookmarkDTO jobBookmarkDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobBookmarkDTO.setMemberNum(memberDTO.getMemberNum());

		int result = jobBookmarkService.add(jobBookmarkDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "관심 공고에 추가했습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "이미 관심 공고에 추가된 공고입니다.");
		}

		return "redirect:/job/detail?jobNum=" + jobBookmarkDTO.getJobNum();
	}

	@PostMapping("delete")
	public String delete(JobBookmarkDTO jobBookmarkDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobBookmarkDTO.setMemberNum(memberDTO.getMemberNum());

		int result = jobBookmarkService.delete(jobBookmarkDTO);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "관심 공고에서 삭제했습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "관심 공고 삭제에 실패했습니다.");
		}

		return "redirect:/job/detail?jobNum=" + jobBookmarkDTO.getJobNum();
	}

	@GetMapping("myList")
	public String myList(@AuthenticationPrincipal MemberDTO memberDTO, JobBookmarkDTO jobBookmarkDTO, Model model)
			throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		jobBookmarkDTO.setMemberNum(memberDTO.getMemberNum());

		model.addAttribute("list", jobBookmarkService.myList(jobBookmarkDTO));

		return "jobBookmark/myList";
	}
}