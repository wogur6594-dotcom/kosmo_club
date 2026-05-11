package com.club.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	public int signUp(MemberDTO memberDTO) throws Exception {
		return memberMapper.signUp(memberDTO);
	}
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception {
		return memberMapper.detail(memberDTO);
	}
}
