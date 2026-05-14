package com.club.app.club.schedule.member;

import java.util.List;

import org.springframework.stereotype.Service;

import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClubScheduleMemberService {

	private final ClubScheduleMemberMapper clubScheduleMemberMapper;
	
	public List<MemberDTO> memberList(Long scheduleNum) throws Exception {
		return clubScheduleMemberMapper.memberList(scheduleNum);
	}
	

	public int join(ClubScheduleMemberDTO clubScheduleMemberDTO) throws Exception {

		Long check = clubScheduleMemberMapper.checkJoin(clubScheduleMemberDTO);

		if (check > 0) {
			return 0;
		}

		return clubScheduleMemberMapper.join(clubScheduleMemberDTO);
	}

	public Long count(Long scheduleNum) throws Exception {
		return clubScheduleMemberMapper.count(scheduleNum);
	}

	public int cancel(ClubScheduleMemberDTO clubScheduleMemberDTO) throws Exception {
		return clubScheduleMemberMapper.cancel(clubScheduleMemberDTO);
	}

	public Long isJoin(ClubScheduleMemberDTO clubScheduleMemberDTO) throws Exception {
		return clubScheduleMemberMapper.isJoin(clubScheduleMemberDTO);
	}
}