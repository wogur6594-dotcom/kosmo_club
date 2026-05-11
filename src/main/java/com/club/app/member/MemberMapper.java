package com.club.app.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {
	public int signUp(MemberDTO memberDTO) throws Exception;
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception;
	
	public int addProfile(MemberProfileDTO memberProfileDTO) throws Exception;
	
	public int delete(MemberDTO memberDTO) throws Exception;
	
	public int update(MemberDTO memberDTO) throws Exception;
	
	public int fileUpdate(MemberProfileDTO memberProfileDTO) throws Exception;
}
