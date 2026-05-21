package com.club.app.restaurant.like;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RestaurantLikeDTO {

	private Long likeNum;
	private Long restaurantNum;
	private Long memberNum;

}