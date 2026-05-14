package com.club.app.club.schedule.member;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubScheduleMemberDTO {

	private Long scheduleMemberNum;

	private Long scheduleNum;

	private Long memberNum;

	private LocalDateTime joinDate;
	
	private Long clubNum;

}