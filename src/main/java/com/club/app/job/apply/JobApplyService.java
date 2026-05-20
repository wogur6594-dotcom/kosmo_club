package com.club.app.job.apply;

import java.util.List;

import org.springframework.stereotype.Service;

import com.club.app.job.JobDTO;
import com.club.app.job.JobService;
import com.club.app.notification.NotificationDTO;
import com.club.app.notification.NotificationService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class JobApplyService {

	private final JobApplyMapper jobApplyMapper;

	private final JobService jobService;

	private final NotificationService notificationService;

	public int apply(JobApplyDTO jobApplyDTO) throws Exception {

		int activeCheck = jobApplyMapper.checkApply(jobApplyDTO);

		if (activeCheck > 0) {
			return 0;
		}

		int allCheck = jobApplyMapper.checkApplyAll(jobApplyDTO);

		if (allCheck > 0) {
			return jobApplyMapper.reApply(jobApplyDTO);
		}

		int result = jobApplyMapper.apply(jobApplyDTO);

		if (result > 0) {

			JobDTO jobDTO = new JobDTO();
			jobDTO.setJobNum(jobApplyDTO.getJobNum());

			jobDTO = jobService.detail(jobDTO);

			NotificationDTO notificationDTO = new NotificationDTO();

			notificationDTO.setMemberNum(jobDTO.getMemberNum());

			notificationDTO.setNotificationContents("새로운 지원자가 있습니다.");

			notificationDTO.setNotificationUrl("/jobApply/applicantList?jobNum=" + jobDTO.getJobNum());

			notificationService.add(notificationDTO);
		}

		return result;
	}

	public int checkApply(JobApplyDTO jobApplyDTO) throws Exception {
		return jobApplyMapper.checkApply(jobApplyDTO);
	}

	public int cancel(JobApplyDTO jobApplyDTO) throws Exception {
		return jobApplyMapper.cancel(jobApplyDTO);
	}

	public List<JobApplyDTO> applicantList(JobApplyDTO jobApplyDTO) throws Exception {
		return jobApplyMapper.applicantList(jobApplyDTO);
	}

	public int updateStatus(JobApplyDTO jobApplyDTO) throws Exception {

		JobApplyDTO applyDetail = jobApplyMapper.jobApplyDetail(jobApplyDTO);

		if (applyDetail == null) {
			return 0;
		}

		if ("ACCEPT".equals(jobApplyDTO.getApplyStatus())) {

			JobDTO jobDTO = new JobDTO();
			jobDTO.setJobNum(applyDetail.getJobNum());

			jobDTO = jobService.detail(jobDTO);

			if (jobDTO.getCurrentApplyMember() >= jobDTO.getJobMaxMember()) {
				return -1;
			}
		}

		int result = jobApplyMapper.updateStatus(jobApplyDTO);

		if (result > 0) {

			JobApplyDTO applyDetailDto = jobApplyMapper.jobApplyDetail(jobApplyDTO);

			NotificationDTO notificationDTO = new NotificationDTO();

			notificationDTO.setMemberNum(applyDetail.getMemberNum());

			if ("ACCEPT".equals(jobApplyDTO.getApplyStatus())) {

				notificationDTO.setNotificationContents("지원한 공고가 승인되었습니다.");

			} else if ("REJECT".equals(jobApplyDTO.getApplyStatus())) {

				notificationDTO.setNotificationContents("지원한 공고가 거절되었습니다.");
			}

			notificationDTO.setNotificationUrl("/jobApply/myList");

			notificationService.add(notificationDTO);
		}

		return result;
	}

	public List<JobApplyDTO> myApplyList(JobApplyDTO jobApplyDTO) throws Exception {
		return jobApplyMapper.myApplyList(jobApplyDTO);
	}

	public JobApplyDTO myApplyStatus(JobApplyDTO jobApplyDTO) throws Exception {
		return jobApplyMapper.myApplyStatus(jobApplyDTO);
	}

}