package com.club.app.club.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClubMemberService {

	@Autowired
	private ClubMemberMapper clubMemberMapper;

	public int join(ClubMemberDTO clubMemberDTO) throws Exception {

		int check = clubMemberMapper.checkJoin(clubMemberDTO);

		if(check > 0) {
			return 0;
		}

		return clubMemberMapper.join(clubMemberDTO);
	}
	
	public int checkJoin(ClubMemberDTO clubMemberDTO) throws Exception {
	    return clubMemberMapper.checkJoin(clubMemberDTO);
	}

}