package com.club.app.job;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JobFileDTO {

	private Long fileNum;
	private Long jobNum;
	private String fileName;
	private String oriName;
}