package com.club.app.restaurant.review;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RestaurantReviewDTO {

	private Long reviewNum;
	private Long restaurantNum;
	private Long memberNum;

	private String reviewContents;
	private Integer reviewScore;

	private LocalDateTime createDate;

	private String memberName;

	public String getCreateDateFormat() {
		if (createDate == null) {
			return "";
		}

		return createDate.toLocalDate().toString();
	}

}