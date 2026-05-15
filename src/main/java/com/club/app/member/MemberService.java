package com.club.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.FileManager;

@Service
public class MemberService implements UserDetailsService {

	@Autowired
	private MemberMapper memberMapper;

	@Autowired
	private FileManager fileManager;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public UserDetails loadUserByUsername(String memberId) throws UsernameNotFoundException {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMemberId(memberId);
		memberDTO = memberMapper.detail(memberDTO);
		return memberDTO;
	}

	public int signUp(MemberDTO memberDTO, MultipartFile attach) throws Exception {

		if (memberMapper.checkId(memberDTO) > 0) {
			throw new RuntimeException("");
		}

		if (memberMapper.checkEmail(memberDTO) > 0) {
			throw new RuntimeException("");
		}
		
		if (memberMapper.checkPhone(memberDTO) > 0) {
			throw new RuntimeException("");
		}

		// DB에 저장
		memberDTO.setMemberPw(passwordEncoder.encode(memberDTO.getMemberPw()));

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

	public boolean checkId(MemberDTO memberDTO) throws Exception {
		int result = memberMapper.checkId(memberDTO);
		return result > 0;
	}

	public boolean checkEmail(MemberDTO memberDTO) throws Exception {
		int result = memberMapper.checkEmail(memberDTO);
		return result > 0;
	}
	
	public boolean checkPhone(MemberDTO memberDTO) throws Exception {
		int result = memberMapper.checkPhone(memberDTO);
		return result > 0;
	}

	public MemberDTO detail(MemberDTO memberDTO) throws Exception {
		return memberMapper.detail(memberDTO);
	}

	public int delete(MemberDTO memberDTO) throws Exception {
		return memberMapper.delete(memberDTO);
	}

	public int update(MemberDTO memberDTO, MultipartFile attach, boolean deleteProfile) throws Exception {

		// 기본 정보 업데이트
		int result = memberMapper.update(memberDTO);

//	    // 비밀번호가 들어왔을 때만 변경
//	    if (memberDTO.getMemberPw() != null && !memberDTO.getMemberPw().isBlank()) {
//
//	        String encodedPw = passwordEncoder.encode(memberDTO.getMemberPw());
//	        memberDTO.setMemberPw(encodedPw);
//
//	        memberMapper.updatePw(memberDTO);
//	    }

		// 이미지 삭제
	    if (deleteProfile && (attach == null || attach.isEmpty())) {

	        MemberDTO detail = memberMapper.detail(memberDTO);

	        if (detail.getProfile() != null) {

	            // 실제 파일 삭제
	            fileManager.fileDelete("memberProfile", detail.getProfile());

	            // DB 삭제
	            MemberProfileDTO profileDTO = new MemberProfileDTO();
	            profileDTO.setMemberNum(memberDTO.getMemberNum());

	            memberMapper.deleteProfile(profileDTO);
	        }

	        return result;
	    }

		// 파일 저장
		if (attach != null && !attach.isEmpty()) {

			// 새 파일 저장
			String fileName = fileManager.fileSave("memberProfile", attach);

			// 프로필 DTO 생성
			MemberProfileDTO profile = new MemberProfileDTO();

			profile.setMemberNum(memberDTO.getMemberNum());
			profile.setFileName(fileName);
			profile.setOriName(attach.getOriginalFilename());

			// 기존 프로필 조회
			MemberDTO detail = memberMapper.detail(memberDTO);

			// 기존 이미지 있는지 검사
			if (detail.getProfile() != null) {

				fileManager.fileDelete("memberProfile", detail.getProfile());

				memberMapper.fileUpdate(profile);

			} else {
				memberMapper.addProfile(profile);
			}
		}
		return result;
	}

	public int updatePw(MemberDTO memberDTO) throws Exception {

		String encodedPw = passwordEncoder.encode(memberDTO.getMemberPw());
		memberDTO.setMemberPw(encodedPw);

		return memberMapper.updatePw(memberDTO);
	}

	public boolean updateEmail(MemberDTO memberDTO) throws Exception {
		MemberDTO user = memberMapper.findEmail(memberDTO);
		// 1. 없으면 중복 아님
		if (user == null)
			return false;

		// 2. 본인이면 OK
		if (user.getMemberNum().equals(memberDTO.getMemberNum()))
			return false;

		// 3. 다른 사람이면 중복
		return true;
	}
	

	public MemberDTO detailByMemberNum(Long memberNum) throws Exception{
	    return memberMapper.detailByMemberNum(memberNum);
	}
}
