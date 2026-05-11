package com.club.app.club.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.club.app.pager.Pager;

@Mapper
public interface ClubBoardMapper {

	public Long getCount(Pager pager) throws Exception;

	public List<ClubBoardDTO> list(Pager pager) throws Exception;

	public ClubBoardDTO detail(ClubBoardDTO clubBoardDTO) throws Exception;

	public int create(ClubBoardDTO clubBoardDTO) throws Exception;

	public int update(ClubBoardDTO clubBoardDTO) throws Exception;

	public int delete(ClubBoardDTO clubBoardDTO) throws Exception;
}