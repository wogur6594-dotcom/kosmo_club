package com.club.app.club.member;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClubMemberDTO {

	private Long clubNum;
	private Long memberNum;
	private Long roleNum;
	private String memberPhone;
	private String memberId;
	private String memberName;

}