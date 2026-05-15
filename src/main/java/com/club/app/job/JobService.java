package com.club.app.job;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JobService {

	private final JobMapper jobMapper;

	@Value("${app.upload.path}")
	private String path;

	public int add(JobDTO jobDTO) throws Exception {

		int result = jobMapper.add(jobDTO);

		if (jobDTO.getAttach() != null && !jobDTO.getAttach().isEmpty()) {

			File folder = new File(path + "job/");

			if (!folder.exists()) {
				folder.mkdirs();
			}

			String fileName = UUID.randomUUID() + "_" + jobDTO.getAttach().getOriginalFilename();

			File file = new File(folder, fileName);

			jobDTO.getAttach().transferTo(file);

			JobFileDTO jobFileDTO = new JobFileDTO();

			jobFileDTO.setJobNum(jobDTO.getJobNum());
			jobFileDTO.setFileName(fileName);
			jobFileDTO.setOriName(jobDTO.getAttach().getOriginalFilename());

			jobMapper.addFile(jobFileDTO);
		}

		return result;
	}

	public List<JobDTO> list(JobPager jobPager) throws Exception {
		jobPager.makePageNum(jobMapper.getCount(jobPager));
		jobPager.makeStartNum();

		return jobMapper.list(jobPager);
	}

	public JobDTO detail(JobDTO jobDTO) throws Exception {
		return jobMapper.detail(jobDTO);
	}

	public int update(JobDTO jobDTO) throws Exception {
		return jobMapper.update(jobDTO);
	}

	public int delete(JobDTO jobDTO, MemberDTO memberDTO) throws Exception {

		boolean isAdmin = memberDTO.getAuthorities().stream()
				.anyMatch(auth -> auth.getAuthority().equals("ROLE_ADMIN"));

		if (isAdmin) {
			return jobMapper.adminDelete(jobDTO);
		}

		jobDTO.setMemberNum(memberDTO.getMemberNum());

		return jobMapper.delete(jobDTO);
	}

}