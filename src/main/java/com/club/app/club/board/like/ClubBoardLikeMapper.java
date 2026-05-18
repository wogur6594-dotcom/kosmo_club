package com.club.app.club.board.like;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClubBoardLikeMapper {

	public int add(ClubBoardLikeDTO clubBoardLikeDTO) throws Exception;

	public int delete(ClubBoardLikeDTO clubBoardLikeDTO) throws Exception;

	public int check(ClubBoardLikeDTO clubBoardLikeDTO) throws Exception;

	public int count(Long boardNum) throws Exception;
}