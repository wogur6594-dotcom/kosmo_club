package com.club.app.club.board.like;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubBoardLikeDTO {

	private Long likeNum;
	private Long boardNum;
	private Long memberNum;
	private LocalDateTime createDate;
}