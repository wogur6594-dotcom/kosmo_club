package com.club.app.club.schedule;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubScheduleDTO {

	private Long scheduleNum;
	private Long clubNum;
	private Long memberNum;
	private String memberName;
	private Long maxMember;

	private String scheduleTitle;
	private String scheduleContents;
	private String scheduleLocation;

	private LocalDateTime scheduleStart;
	private LocalDateTime scheduleEnd;

	private Integer scheduleMax;

	private LocalDateTime createDate;
}