package com.club.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member/*")
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;

	@GetMapping("signUp")
	public void signUp() throws Exception {

	}

	@GetMapping("/")
	public String index() throws Exception{
		return "index";
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
	public String delete(Authentication auth, HttpServletRequest request, HttpServletResponse response) throws Exception {
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
	public String update(MemberDTO memberDTO,
	                     @RequestParam(name="attach", required=false) MultipartFile attach,
	                     Authentication auth) throws Exception {

	    MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

	    memberDTO.setMemberId(loginUser.getMemberId());
	    memberDTO.setMemberNum(loginUser.getMemberNum());

	    memberService.update(memberDTO, attach);

	    return "redirect:/member/detail";
	}
}
