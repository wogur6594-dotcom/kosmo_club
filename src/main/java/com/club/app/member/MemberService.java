package com.club.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.FileManager;

@Service
public class MemberService {

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private FileManager fileManager;

	public int signUp(MemberDTO memberDTO, MultipartFile attach) throws Exception {

		// 1. 회원가입
		int result = memberMapper.signUp(memberDTO);

		// 2. 파일 업로드
		if (attach != null && !attach.isEmpty()) {

			// 실제 파일 저장
			String fileName = fileManager.fileSave("memberProfile", attach);

			// DB 저장 DTO
			MemberProfileDTO profileDTO = new MemberProfileDTO();

			profileDTO.setMemberNum(memberDTO.getMemberNum());

			profileDTO.setFileName(fileName);

			profileDTO.setOriName(attach.getOriginalFilename());

			// profile 테이블 insert
			memberMapper.addProfile(profileDTO);
		}

		return result;
	}

	public MemberDTO detail(MemberDTO memberDTO) throws Exception {
		return memberMapper.detail(memberDTO);
	}
}
