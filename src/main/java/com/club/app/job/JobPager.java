package com.club.app.job;

import java.util.Arrays;

import com.club.app.pager.Pager;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class JobPager extends Pager {

	private String[] jobCategory;
	private String[] jobType;

	public boolean checkedCategory(String category) {

		if (jobCategory == null) {
			return false;
		}

		return Arrays.asList(jobCategory).contains(category);
	}

	public boolean checkedType(String type) {

		if (jobType == null) {
			return false;
		}

		return Arrays.asList(jobType).contains(type);
	}
}