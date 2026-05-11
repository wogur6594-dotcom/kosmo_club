package com.club.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/*")
public class MeberController {

	@Autowired
	private MemberService memberService;

	@GetMapping("signUp")
	public void signUp() throws Exception {

	}

	@PostMapping("signUp")
	public String signUp(MemberDTO memberDTO, @RequestParam(name = "attach", required = false) MultipartFile attach)
			throws Exception {

		memberService.signUp(memberDTO, attach);

		return "redirect:/";
	}

	@GetMapping("login")
	public void login(MemberDTO memberDTO) throws Exception {
	}

	@GetMapping("logout")
	public String logout(HttpSession session) throws Exception {
		session.invalidate();
		return "redirect:/";
	}

	@PostMapping("login")
	public String login(MemberDTO memberDTO, HttpSession session) throws Exception {
		MemberDTO login = memberService.detail(memberDTO);
		session.setAttribute("member", login);
		return "redirect:/";
	}

	@GetMapping("detail")
	public void detail(MemberDTO memberDTO, Model model, HttpSession session) throws Exception {
		MemberDTO dto = (MemberDTO) session.getAttribute("member");
		model.addAttribute("detail", dto);
	}

	@PostMapping("delete")
	public String delete(MemberDTO memberDTO, HttpSession session) throws Exception {
		MemberDTO dto = (MemberDTO) session.getAttribute("member");
		memberService.delete(dto);
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("update")
	public void update(HttpSession session, Model model) throws Exception {

		MemberDTO dto = (MemberDTO) session.getAttribute("member");
		MemberDTO update = memberService.detail(dto);
		model.addAttribute("update", update);
	}

	@PostMapping("update")
	public String update(MemberDTO memberDTO,@RequestParam(name="attach", required = false) MultipartFile attach, HttpSession session) throws Exception {

		MemberDTO member = (MemberDTO) session.getAttribute("member");

		memberDTO.setMemberNum(member.getMemberNum());
		memberDTO.setMemberId(member.getMemberId());

		memberService.update(memberDTO, attach);

		// 세션 갱신
		member = memberService.detail(memberDTO);

		session.setAttribute("member", member);

		return "redirect:./detail";
	}

}
