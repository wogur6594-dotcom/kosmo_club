package com.club.app.restaurant.file;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RestaurantFileDTO {

	private Long fileNum;
	private Long restaurantNum;

	private String fileName;
	private String oriName;

}