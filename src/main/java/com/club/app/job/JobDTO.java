package com.club.app.job;

import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JobDTO {

	private Long jobNum;
	private Long memberNum;

	private JobFileDTO jobFileDTO;
	private MultipartFile attach;
	private String jobTitle;
	private String jobContents;
	private String jobCategory;
	private String jobLocation;
	private String jobPay;
	private String jobWorkDay;
	private String jobWorkTime;
	private String jobType;
	private String fileName;
	private String oriName;

	private LocalDateTime createDate;

	private String memberName;

	public String getCreateDateFormat() {

		if (createDate == null) {
			return "";
		}

		return createDate.toLocalDate().toString();
	}

}