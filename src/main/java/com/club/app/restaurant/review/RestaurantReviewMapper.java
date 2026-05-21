package com.club.app.restaurant.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RestaurantReviewMapper {

	public int add(RestaurantReviewDTO restaurantReviewDTO) throws Exception;

	public List<RestaurantReviewDTO> list(RestaurantReviewDTO restaurantReviewDTO) throws Exception;

	public int delete(RestaurantReviewDTO restaurantReviewDTO) throws Exception;

	public int update(RestaurantReviewDTO restaurantReviewDTO) throws Exception;

}