package com.club.app.club.member;

import java.util.List;

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

	public List<ClubMemberDTO> waitList(Long clubNum) throws Exception;

	public int approve(ClubMemberDTO clubMemberDTO) throws Exception;

	public int checkWaitingMember(ClubMemberDTO clubMemberDTO) throws Exception;

	public Long getRoleNum(ClubMemberDTO clubMemberDTO) throws Exception;

	public int kickMember(ClubMemberDTO clubMemberDTO) throws Exception;

	public List<ClubMemberDTO> memberList(Long clubNum) throws Exception;

	public int leave(ClubMemberDTO clubMemberDTO) throws Exception;

	public int delegateOwnerToMember(ClubMemberDTO clubMemberDTO) throws Exception;

	public int downgradeOwner(ClubMemberDTO clubMemberDTO) throws Exception;

}