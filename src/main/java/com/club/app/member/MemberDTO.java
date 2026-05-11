package com.club.app.member;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	
	private Long memberNum;
	private String memberName;
	private String memberEmail;
	private Long memberPhone;
	private LocalDate memberBirth;
	private Long roleNum;
	private String memberId;
	private String memberPw;
	
	private MemberProfileDTO profile;

}
