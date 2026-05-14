package com.club.app.club.board.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClubBoardCommentMapper {

	// 댓글 목록
	public List<ClubBoardCommentDTO> list(Long boardNum) throws Exception;

	// 댓글 등록
	public int add(ClubBoardCommentDTO clubBoardCommentDTO) throws Exception;

	// 댓글 삭제
	public int delete(Long commentNum) throws Exception;

}