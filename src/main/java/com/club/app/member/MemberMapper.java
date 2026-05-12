package com.club.app.member;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Mapper
public interface MemberMapper {
	public int signUp(MemberDTO memberDTO) throws Exception;
	
	public MemberDTO detail(MemberDTO memberDTO) throws UsernameNotFoundException;
	
	public int addProfile(MemberProfileDTO memberProfileDTO) throws Exception;
	
	public int delete(MemberDTO memberDTO) throws Exception;
	
	public int update(MemberDTO memberDTO) throws Exception;
	
	public int fileUpdate(MemberProfileDTO memberProfileDTO) throws Exception;
	
	public int updatePw(MemberDTO memberDTO) throws Exception;
	
	public int checkId(MemberDTO memberDTO) throws Exception;
	
	public int checkEmail(MemberDTO memberDTO) throws Exception;
}
