package com.club.app.club;

import com.club.app.file.FileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubDTO {
	
	private Long clubNum;
	
	private String clubName;
	
	private String clubCategory;
	
	private String clubLocation;
	
	private Long clubMax;
	
	private FileDTO fileDTO;
	
	private Long currentMember;

}
