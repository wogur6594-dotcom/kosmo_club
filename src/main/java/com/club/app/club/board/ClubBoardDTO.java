package com.club.app.club.board;

import java.time.LocalDateTime;

import com.club.app.club.ClubDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubBoardDTO {

	private ClubDTO clubDTO;

	private Long boardNum;

	private Long clubNum;

	private String boardTitle;

	private String boardContents;

	private LocalDateTime createDate;

	private String boardCategory;

	private String boardWriter;
}