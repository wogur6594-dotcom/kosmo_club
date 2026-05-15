package com.club.app.club.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClubMemberMapper {

	public int join(ClubMemberDTO clubMemberDTO) throws Exception;

	public int checkJoin(ClubMemberDTO clubMemberDTO) throws Exception;

	public Long getCurrentMember(Long clubNum) throws Exception;

	public Long getClubMax(Long clubNum) throws Exception;

	public Long getClubOwnerMemberNum(Long clubNum) throws Exception;

	public String getClubName(Long clubNum) throws Exception;

	public int checkApprovedMember(ClubMemberDTO clubMemberDTO) throws Exception;

}