package com.club.app.club.board;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubFileDTO {

	private Long fileNum;

	private Long boardNum;

	private String fileName;

	private String oriName;

	private Boolean isMain;

}