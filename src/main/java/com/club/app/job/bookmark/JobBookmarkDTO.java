package com.club.app.job.bookmark;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JobBookmarkDTO {

	private Long bookmarkNum;
	private Long jobNum;
	private Long memberNum;
	private LocalDateTime createDate;

	private String jobTitle;
	private String jobCategory;
	private String jobType;
	private String jobLocation;
	private String jobPay;
	private String jobWorkDay;
	private String jobWorkTime;
	private Long jobMaxMember;
	private Long currentApplyMember;
	private String memberName;
	private String fileName;
	private String oriName;

	public String getCreateDateFormat() {
		if (createDate == null) {
			return "";
		}

		return createDate.toLocalDate().toString();
	}
}