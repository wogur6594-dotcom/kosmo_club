package com.club.app.job.apply;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JobApplyMapper {

	public int apply(JobApplyDTO jobApplyDTO) throws Exception;

	public int checkApply(JobApplyDTO jobApplyDTO) throws Exception;

	public int cancel(JobApplyDTO jobApplyDTO) throws Exception;

	public List<JobApplyDTO> applicantList(JobApplyDTO jobApplyDTO) throws Exception;

	public int updateStatus(JobApplyDTO jobApplyDTO) throws Exception;

	public List<JobApplyDTO> myApplyList(JobApplyDTO jobApplyDTO) throws Exception;

	public JobApplyDTO jobApplyDetail(JobApplyDTO jobApplyDTO) throws Exception;

	public int reApply(JobApplyDTO jobApplyDTO) throws Exception;

	public int checkApplyAll(JobApplyDTO jobApplyDTO) throws Exception;

	public JobApplyDTO myApplyStatus(JobApplyDTO jobApplyDTO) throws Exception;

}