package com.club.app.restaurant;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.club.app.pager.Pager;
import com.club.app.restaurant.file.RestaurantFileDTO;
import com.club.app.restaurant.like.RestaurantLikeDTO;

@Mapper
public interface RestaurantMapper {

	public int add(RestaurantDTO restaurantDTO) throws Exception;

	public int addFile(RestaurantFileDTO restaurantFileDTO) throws Exception;

	public List<RestaurantDTO> list(Pager pager) throws Exception;

	public RestaurantDTO detail(RestaurantDTO restaurantDTO) throws Exception;

	public Long getCount(Pager pager) throws Exception;

	public int addLike(RestaurantLikeDTO restaurantLikeDTO) throws Exception;

	public int deleteLike(RestaurantLikeDTO restaurantLikeDTO) throws Exception;

	public int checkLike(RestaurantLikeDTO restaurantLikeDTO) throws Exception;

	public Long getLikeCount(RestaurantDTO restaurantDTO) throws Exception;

	public List<RestaurantDTO> popularList() throws Exception;

	public int updateHit(RestaurantDTO restaurantDTO) throws Exception;

	public int update(RestaurantDTO restaurantDTO) throws Exception;

	public int delete(RestaurantDTO restaurantDTO) throws Exception;

	public RestaurantFileDTO fileDetail(RestaurantFileDTO restaurantFileDTO) throws Exception;

	public int deleteFile(RestaurantFileDTO restaurantFileDTO) throws Exception;

	public RestaurantDTO getReviewSummary(RestaurantDTO restaurantDTO) throws Exception;

}