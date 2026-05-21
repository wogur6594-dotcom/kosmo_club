package com.club.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.ClubService;
import com.club.app.club.board.ClubBoardDTO;
import com.club.app.club.board.ClubBoardService;
import com.club.app.club.member.ClubMemberDTO;
import com.club.app.job.JobDTO;
import com.club.app.job.JobService;
import com.club.app.job.apply.JobApplyDTO;
import com.club.app.job.apply.JobApplyService;
import com.club.app.notification.NotificationService;

import org.springframework.dao.DuplicateKeyException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private PasswordEncoder passwordEncoder;
//필드 추가
	@Autowired
	private ClubService clubService;

	@Autowired
	private ClubBoardService clubBoardService;

	@Autowired
	private JobService jobService;

	@Autowired
	private JobApplyService jobApplyService;

	@Autowired
	private NotificationService notificationService;

//필드 추가 끝
	@GetMapping("/")
	public String index() throws Exception {
		return "index";
	}

	@GetMapping("signUp")
	public String signUp() throws Exception {
		return "member/signUp";
	}

	@PostMapping("signUp")
	public String signUp(@Validated(SignUpGroup.class) MemberDTO memberDTO, BindingResult bindingResult,
			@RequestParam(name = "attach", required = false) MultipartFile attach) throws Exception {

		if (bindingResult.hasErrors()) {
			return "member/signUp";
		}

		memberService.signUp(memberDTO, attach);

		return "redirect:/";
	}

	@GetMapping("checkId")
	@ResponseBody
	public boolean checkId(MemberDTO memberDTO) throws Exception {
		return memberService.checkId(memberDTO);
	}

	@GetMapping("checkEmail")
	@ResponseBody
	public boolean checkEmail(MemberDTO memberDTO) throws Exception {
		return memberService.checkEmail(memberDTO);
	}

	@GetMapping("checkPhone")
	@ResponseBody
	public boolean checkPhone(MemberDTO memberDTO) throws Exception {
		return memberService.checkPhone(memberDTO);
	}

	@GetMapping("login")
	public void login(MemberDTO memberDTO) throws Exception {
	}

//	@GetMapping("logout")
//	public String logout(HttpSession session) throws Exception {
//		session.invalidate();
//		return "redirect:/";
//	}

//	@PostMapping("login")
//	public String login(MemberDTO memberDTO, HttpSession session) throws Exception {
//		MemberDTO login = memberService.detail(memberDTO);
//		session.setAttribute("member", login);
//		return "redirect:/";
//	}

	@GetMapping("detail")
	public String detail(Authentication auth, Model model) throws Exception {

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		MemberDTO detail = memberService.detail(loginUser);

		model.addAttribute("detail", detail);

		return "member/detail";
	}

	@PostMapping("delete")
	public String delete(Authentication auth, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		MemberDTO member = (MemberDTO) auth.getPrincipal();
		memberService.delete(member);
		new SecurityContextLogoutHandler().logout(request, response, auth);
		return "redirect:/";
	}

	@GetMapping("update")
	public String update(Model model, Authentication auth) throws Exception {

		MemberDTO member = (MemberDTO) auth.getPrincipal();

		MemberDTO update = memberService.detail(member);

		model.addAttribute("update", update);

		return "member/update";
	}

	@PostMapping("update")
	public String update(@Validated(UpdateGroup.class) @ModelAttribute("update") MemberDTO memberDTO,
			BindingResult bindingResult, @RequestParam(name = "attach", required = false) MultipartFile attach,
			@RequestParam(name = "deleteProfile", defaultValue = "false") boolean deleteProfile, Authentication auth,
			Model model) throws Exception {

		if (bindingResult.hasErrors()) {
			MemberDTO memberProfile = memberService.detail(memberDTO);
			// 기존 프로필 복구
			memberDTO.setProfile(memberProfile.getProfile());
			model.addAttribute("update", memberDTO);
			return "member/update";
		}

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		memberDTO.setMemberId(loginUser.getMemberId());
		memberDTO.setMemberNum(loginUser.getMemberNum());
		memberDTO.setMemberBirth(loginUser.getMemberBirth());
		memberDTO.setMemberName(loginUser.getMemberName());

		try {
			memberService.update(memberDTO, attach, deleteProfile);
		} catch (DuplicateKeyException e) {
			if (e.getMessage().contains("MEMBER_PHONE")) {
				bindingResult.rejectValue("memberPhone", "duplicate", "이미 사용중인 전화번호입니다.");
			} else if (e.getMessage().contains("MEMBER_EMAIL")) {
				bindingResult.rejectValue("memberEmail", "duplicate", "이미 사용중인 이메일입니다.");
			} else {
				bindingResult.reject("duplicate", "이미 존재하는 정보입니다.");
			}
			MemberDTO memberProfile = memberService.detail(memberDTO);
			memberDTO.setProfile(memberProfile.getProfile());
			model.addAttribute("update", memberDTO);
			return "member/update";
		}

		return "redirect:/member/detail";
	}

	@PostMapping("emailCheck")
	@ResponseBody
	public boolean emailCheck(MemberDTO memberDTO, Authentication auth) throws Exception {

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		memberDTO.setMemberNum(loginUser.getMemberNum());

		return memberService.updateEmail(memberDTO);
	}

	@GetMapping("pwChange")
	public void pwChange() throws Exception {
	}

	@PostMapping("pwChange")
	public String pwChange(@Validated(PasswordGroup.class) @ModelAttribute MemberDTO memberDTO, BindingResult bindingResult, Authentication auth, RedirectAttributes rttr)
			throws Exception {

		if (bindingResult.hasErrors()) {
			return "member/pwChange";
		}

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();
		memberDTO.setMemberNum(loginUser.getMemberNum());

		memberService.updatePw(memberDTO);

		rttr.addFlashAttribute("msg", "비밀번호가 변경되었습니다");

		return "redirect:/member/detail";
	}

	@PostMapping("checkPw")
	@ResponseBody
	public boolean checkPw(@RequestParam("pw") String pw, Authentication auth) throws Exception {

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		MemberDTO dbUser = memberService.detail(loginUser);

		return passwordEncoder.matches(pw, dbUser.getMemberPw());
	}

	// mypage 추가
	@GetMapping("mypage")
	public String myPage(@AuthenticationPrincipal MemberDTO memberDTO, Model model) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		MemberDTO detail = memberService.detail(memberDTO);

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		ClubBoardDTO clubBoardDTO = new ClubBoardDTO();
		clubBoardDTO.setMemberId(memberDTO.getMemberId());

		JobDTO jobDTO = new JobDTO();
		jobDTO.setMemberNum(memberDTO.getMemberNum());

		JobApplyDTO jobApplyDTO = new JobApplyDTO();
		jobApplyDTO.setMemberNum(memberDTO.getMemberNum());

		model.addAttribute("detail", detail);
		model.addAttribute("myClubList", clubService.myClubList(clubMemberDTO));
		model.addAttribute("myBoardList", clubBoardService.myBoardList(clubBoardDTO));
		model.addAttribute("myJobList", jobService.myJobList(jobDTO));
		model.addAttribute("myApplyList", jobApplyService.myApplyList(jobApplyDTO));
		model.addAttribute("notificationList", notificationService.recentList(memberDTO.getMemberNum()));

		return "member/mypage";
	}
	// mypage 끝
}
