package com.club.app.club.chat;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.club.ClubDTO;
import com.club.app.club.ClubService;
import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberService;
import com.club.app.file.S3Service;
import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/clubChat/*")
public class ClubChatController {

	private final ClubMemberService clubMemberService;
	private final ClubMessageService clubMessageService;
	private final ClubService clubService;
	private final S3Service s3Service;

	@GetMapping("room")
	public String room(@RequestParam("clubNum") Long clubNum, @AuthenticationPrincipal MemberDTO memberDTO, Model model,
			RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubNum);
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());

		int check = clubMemberService.checkApprovedMember(clubMemberDTO);

		if (check == 0) {
			redirectAttributes.addFlashAttribute("msg", "동호회 가입 회원만 채팅을 사용할 수 있습니다.");
			return "redirect:/club/detail?clubNum=" + clubNum;
		}

		ClubDTO clubDTO = new ClubDTO();
		clubDTO.setClubNum(clubNum);
		clubDTO = clubService.detail(clubDTO);

		List<ClubMessageDTO> messageList = clubMessageService.list(clubNum);

		model.addAttribute("clubNum", clubNum);
		model.addAttribute("clubName", clubDTO.getClubName());
		model.addAttribute("messageList", messageList);

		return "clubChat/room";
	}

	@PostMapping("imageUpload")
	@ResponseBody
	public String imageUpload(@RequestParam("file") MultipartFile file, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "login";
		}

		if (file == null || file.isEmpty()) {
			return "fail";
		}

		String oriName = file.getOriginalFilename();

		if (oriName == null) {
			return "fail";
		}

		String lowerName = oriName.toLowerCase();

		if (!(lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg") || lowerName.endsWith(".png")
				|| lowerName.endsWith(".gif") || lowerName.endsWith(".webp"))) {
			return "typeFail";
		}

		// S3 업로드 적용
		String fileUrl = s3Service.upload(file, "clubChat");

		return fileUrl;
	}
}