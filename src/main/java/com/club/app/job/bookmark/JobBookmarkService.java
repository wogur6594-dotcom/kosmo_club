package com.club.app.job.bookmark;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JobBookmarkService {

	private final JobBookmarkMapper jobBookmarkMapper;

	public int add(JobBookmarkDTO jobBookmarkDTO) throws Exception {
		return jobBookmarkMapper.add(jobBookmarkDTO);
	}

	public int delete(JobBookmarkDTO jobBookmarkDTO) throws Exception {
		return jobBookmarkMapper.delete(jobBookmarkDTO);
	}

	public int check(JobBookmarkDTO jobBookmarkDTO) throws Exception {
		return jobBookmarkMapper.check(jobBookmarkDTO);
	}

	public List<JobBookmarkDTO> myList(JobBookmarkDTO jobBookmarkDTO) throws Exception {
		return jobBookmarkMapper.myList(jobBookmarkDTO);
	}
}