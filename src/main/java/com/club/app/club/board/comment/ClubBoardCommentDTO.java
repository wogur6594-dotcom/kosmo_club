package com.club.app.club.board.comment;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubBoardCommentDTO {

	private String memberId;
	private Long commentNum;
	private Long boardNum;
	private Long memberNum;
	private String memberName;
	private String commentContents;
	private LocalDateTime createDate;
}