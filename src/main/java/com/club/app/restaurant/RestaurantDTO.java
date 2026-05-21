package com.club.app.restaurant;

import java.time.LocalDateTime;
import java.util.List;

import com.club.app.restaurant.file.RestaurantFileDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RestaurantDTO {

	private Long restaurantNum;
	private Long memberNum;

	private Double restaurantLat;
	private Double restaurantLng;
	private String restaurantName;
	private String restaurantCategory;
	private String restaurantLocation;
	private String restaurantContents;
	private Double avgScore;
	private String restaurantDetailAddress;

	private Integer reviewCount;
	private Long hit;
	private String restaurantPhone;
	private String restaurantTime;

	private Double restaurantScore;

	private LocalDateTime createDate;
	private String fileName;
	private String memberName;

	private List<RestaurantFileDTO> fileDTOs;

	public String getCreateDateFormat() {
		if (createDate == null) {
			return "";
		}

		return createDate.toLocalDate().toString();
	}

	private Long likeCount;
	private Boolean liked;

}