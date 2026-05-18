package com.club.app.job.apply;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class JobApplyDTO {

	private Long applyNum;
	private Long jobNum;
	private Long memberNum;

	private String applyStatus;
	private LocalDateTime applyDate;

	private String memberName;
	private String memberPhone;
	private String memberEmail;

	private String jobTitle;

	private String jobLocation;
	private String jobPay;
	private String jobWorkDay;
	private String jobWorkTime;

	public String getApplyDateFormat() {
		if (applyDate == null) {
			return "";
		}

		return applyDate.toLocalDate().toString();
	}
}