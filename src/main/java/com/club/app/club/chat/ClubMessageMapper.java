package com.club.app.club.chat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClubMessageMapper {

	public int insert(ClubMessageDTO clubMessageDTO) throws Exception;

	public List<ClubMessageDTO> list(Long clubNum) throws Exception;
}