package com.club.app.club.schedule.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.club.app.member.MemberDTO;

@Mapper
public interface ClubScheduleMemberMapper {

	// 참가하기
	public int join(ClubScheduleMemberDTO clubScheduleMemberDTO);

	// 이미 참가했는지 확인
	public Long checkJoin(ClubScheduleMemberDTO clubScheduleMemberDTO);

	// 참가 인원 수
	public Long count(Long scheduleNum);

	// 참가 취소
	public int cancel(ClubScheduleMemberDTO clubScheduleMemberDTO);

	// 참가 여부 확인
	public Long isJoin(ClubScheduleMemberDTO clubScheduleMemberDTO);

	public List<MemberDTO> memberList(Long scheduleNum);

}