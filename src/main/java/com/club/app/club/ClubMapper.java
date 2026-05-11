package com.club.app.club;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.club.app.file.FileDTO;
import com.club.app.pager.Pager;

@Mapper
public interface ClubMapper {

	// CRUD
	public Long getCount(Pager pager) throws Exception;

	// R-read
	public List<ClubDTO> list(Pager pager) throws Exception;

	public ClubDTO detail(ClubDTO clubDTO) throws Exception;

	// C - create
	public int create(ClubDTO clubDTO) throws Exception;

	public int createFile(FileDTO fileDTO) throws Exception;

	// U - update
	public int update(ClubDTO clubDTO) throws Exception;

	// D - delete
	public int delete(ClubDTO clubDTO) throws Exception;

}