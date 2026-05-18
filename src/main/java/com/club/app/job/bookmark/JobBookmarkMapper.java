package com.club.app.job.bookmark;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JobBookmarkMapper {

	public int add(JobBookmarkDTO jobBookmarkDTO) throws Exception;

	public int delete(JobBookmarkDTO jobBookmarkDTO) throws Exception;

	public int check(JobBookmarkDTO jobBookmarkDTO) throws Exception;

	public List<JobBookmarkDTO> myList(JobBookmarkDTO jobBookmarkDTO) throws Exception;
}