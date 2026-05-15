package com.club.app.job;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JobMapper {

	public int add(JobDTO jobDTO) throws Exception;

	public List<JobDTO> list(JobPager jobPager) throws Exception;

	public Long getCount(JobPager jobPager) throws Exception;

	public JobDTO detail(JobDTO jobDTO) throws Exception;

	public int update(JobDTO jobDTO) throws Exception;

	public int delete(JobDTO jobDTO) throws Exception;

	public int adminDelete(JobDTO jobDTO) throws Exception;

	public int addFile(JobFileDTO jobFileDTO) throws Exception;

	public JobFileDTO fileDetail(JobDTO jobDTO) throws Exception;

	public int deleteFile(JobDTO jobDTO) throws Exception;

}