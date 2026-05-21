package com.club.app.restaurant.review;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestaurantReviewService {

	private final RestaurantReviewMapper restaurantReviewMapper;

	public int add(RestaurantReviewDTO restaurantReviewDTO) throws Exception {
		return restaurantReviewMapper.add(restaurantReviewDTO);
	}

	public List<RestaurantReviewDTO> list(RestaurantReviewDTO restaurantReviewDTO) throws Exception {
		return restaurantReviewMapper.list(restaurantReviewDTO);
	}

	public int delete(RestaurantReviewDTO restaurantReviewDTO) throws Exception {
		return restaurantReviewMapper.delete(restaurantReviewDTO);
	}

	public int update(RestaurantReviewDTO restaurantReviewDTO) throws Exception {
		return restaurantReviewMapper.update(restaurantReviewDTO);
	}

}