package com.club.app.restaurant.review;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.club.app.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/restaurantReview/*")
public class RestaurantReviewController {

	private final RestaurantReviewService restaurantReviewService;

	@PostMapping("add")
	@ResponseBody
	public RestaurantReviewDTO add(RestaurantReviewDTO restaurantReviewDTO,
			@AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		if (memberDTO == null) {
			return null;
		}

		restaurantReviewDTO.setMemberNum(memberDTO.getMemberNum());

		restaurantReviewService.add(restaurantReviewDTO);

		restaurantReviewDTO.setMemberName(memberDTO.getMemberName());

		return restaurantReviewDTO;
	}

	@PostMapping("delete")
	@ResponseBody
	public String delete(RestaurantReviewDTO restaurantReviewDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "login";
		}

		restaurantReviewDTO.setMemberNum(memberDTO.getMemberNum());

		int result = restaurantReviewService.delete(restaurantReviewDTO);

		return String.valueOf(result);
	}

	@PostMapping("update")
	@ResponseBody
	public String update(RestaurantReviewDTO restaurantReviewDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "login";
		}

		restaurantReviewDTO.setMemberNum(memberDTO.getMemberNum());

		int result = restaurantReviewService.update(restaurantReviewDTO);

		return String.valueOf(result);
	}

}