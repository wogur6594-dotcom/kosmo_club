package com.club.app.club.schedule;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClubScheduleMapper {

	public List<ClubScheduleDTO> list(Long clubNum);

	public int create(ClubScheduleDTO clubScheduleDTO);

	public ClubScheduleDTO detail(ClubScheduleDTO clubScheduleDTO);

	public int delete(ClubScheduleDTO clubScheduleDTO) throws Exception;

	public int update(ClubScheduleDTO clubScheduleDTO) throws Exception;

	public List<ClubScheduleDTO> totalList() throws Exception;

}