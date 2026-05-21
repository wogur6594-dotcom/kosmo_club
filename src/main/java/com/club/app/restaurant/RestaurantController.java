package com.club.app.restaurant;

import java.util.List;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.member.MemberDTO;
import com.club.app.pager.Pager;
import com.club.app.restaurant.file.RestaurantFileDTO;
import com.club.app.restaurant.like.RestaurantLikeDTO;
import com.club.app.restaurant.review.RestaurantReviewDTO;
import com.club.app.restaurant.review.RestaurantReviewService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/restaurant/*")
public class RestaurantController {

	private final RestaurantReviewService restaurantReviewService;
	private final RestaurantService restaurantService;

	@GetMapping("list")
	public String list(Pager pager, Model model) throws Exception {

		List<RestaurantDTO> list = restaurantService.list(pager);

		model.addAttribute("list", list);
		model.addAttribute("pager", pager);

		return "restaurant/list";
	}

	@GetMapping("create")
	public String create(@AuthenticationPrincipal MemberDTO memberDTO) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		return "restaurant/create";
	}

	@PostMapping("create")
	public String create(RestaurantDTO restaurantDTO, @RequestParam("files") MultipartFile[] files,
			@AuthenticationPrincipal MemberDTO memberDTO, RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		restaurantDTO.setMemberNum(memberDTO.getMemberNum());

		int result = restaurantService.add(restaurantDTO, files);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "맛집이 등록되었습니다.");
			return "redirect:/restaurant/detail?restaurantNum=" + restaurantDTO.getRestaurantNum();
		}

		redirectAttributes.addFlashAttribute("message", "맛집 등록에 실패했습니다.");
		return "redirect:/restaurant/create";
	}

	@GetMapping("detail")
	public String detail(RestaurantDTO restaurantDTO, Model model, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		restaurantDTO = restaurantService.detail(restaurantDTO);

		if (restaurantDTO == null) {
			return "redirect:/restaurant/list";
		}

		Long likeCount = restaurantService.getLikeCount(restaurantDTO);

		restaurantDTO.setLikeCount(likeCount);

		if (memberDTO != null) {

			RestaurantLikeDTO restaurantLikeDTO = new RestaurantLikeDTO();

			restaurantLikeDTO.setRestaurantNum(restaurantDTO.getRestaurantNum());
			restaurantLikeDTO.setMemberNum(memberDTO.getMemberNum());

			int check = restaurantService.checkLike(restaurantLikeDTO);

			restaurantDTO.setLiked(check > 0);
		}
		RestaurantReviewDTO restaurantReviewDTO = new RestaurantReviewDTO();
		restaurantReviewDTO.setRestaurantNum(restaurantDTO.getRestaurantNum());

		List<RestaurantReviewDTO> reviewList = restaurantReviewService.list(restaurantReviewDTO);

		model.addAttribute("reviewList", reviewList);
		model.addAttribute("member", memberDTO);
		model.addAttribute("dto", restaurantDTO);

		return "restaurant/detail";
	}

	@PostMapping("like")
	@ResponseBody
	public String like(RestaurantLikeDTO restaurantLikeDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "login";
		}

		restaurantLikeDTO.setMemberNum(memberDTO.getMemberNum());

		int result = restaurantService.like(restaurantLikeDTO);

		int check = restaurantService.checkLike(restaurantLikeDTO);

		if (check > 0) {
			return "add";
		}

		return "delete";
	}

	@GetMapping("update")
	public String update(RestaurantDTO restaurantDTO, @AuthenticationPrincipal MemberDTO memberDTO, Model model,
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "search", required = false) String search) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		restaurantDTO = restaurantService.detail(restaurantDTO);

		if (restaurantDTO == null) {
			return "redirect:/restaurant/list";
		}

		if (!restaurantDTO.getMemberNum().equals(memberDTO.getMemberNum())) {

			String redirectUrl = "redirect:/restaurant/detail?restaurantNum=" + restaurantDTO.getRestaurantNum();

			if (page != null && !page.isBlank()) {
				redirectUrl += "&page=" + page;
			}

			if (search != null && !search.isBlank()) {
				redirectUrl += "&search=" + search;
			}

			return redirectUrl;
		}

		model.addAttribute("dto", restaurantDTO);

		return "restaurant/update";
	}

	@PostMapping("update")
	public String update(RestaurantDTO restaurantDTO,
			@RequestParam(value = "files", required = false) MultipartFile[] files,
			@RequestParam(value = "deleteFileNums", required = false) List<Long> deleteFileNums,
			@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "search", required = false) String search,
			@AuthenticationPrincipal MemberDTO memberDTO, RedirectAttributes redirectAttributes) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		restaurantDTO.setMemberNum(memberDTO.getMemberNum());

		int result = restaurantService.update(restaurantDTO, files, deleteFileNums);

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "맛집 정보가 수정되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "수정 권한이 없거나 수정에 실패했습니다.");
		}

		String redirectUrl = "redirect:./detail?restaurantNum=" + restaurantDTO.getRestaurantNum();

		if (page != null && !page.isBlank()) {
			redirectUrl += "&page=" + page;
		}

		if (search != null && !search.isBlank()) {
			redirectUrl += "&search=" + search;
		}

		return redirectUrl;
	}

	@PostMapping("delete")
	public String delete(RestaurantDTO restaurantDTO, @AuthenticationPrincipal MemberDTO memberDTO,
			RedirectAttributes redirectAttributes, @RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "search", required = false) String search) throws Exception {

		if (memberDTO == null) {
			return "redirect:/member/login";
		}

		restaurantDTO.setMemberNum(memberDTO.getMemberNum());

		int result = restaurantService.delete(restaurantDTO);

		String redirectUrl = "redirect:/restaurant/list";

		if (page != null && !page.isBlank()) {
			redirectUrl += "?page=" + page;
		}

		if (search != null && !search.isBlank()) {
			if (redirectUrl.contains("?")) {
				redirectUrl += "&search=" + search;
			} else {
				redirectUrl += "?search=" + search;
			}
		}

		if (result > 0) {
			redirectAttributes.addFlashAttribute("message", "맛집이 삭제되었습니다.");
		}

		return redirectUrl;
	}

	@PostMapping("deleteFile")
	@ResponseBody
	public String deleteFile(RestaurantFileDTO restaurantFileDTO, @AuthenticationPrincipal MemberDTO memberDTO)
			throws Exception {

		if (memberDTO == null) {
			return "login";
		}

		int result = restaurantService.deleteFile(restaurantFileDTO);

		if (result > 0) {
			return "1";
		}

		return "0";
	}

	@PostMapping("reviewSummary")
	@ResponseBody
	public RestaurantDTO reviewSummary(RestaurantDTO restaurantDTO) throws Exception {

		return restaurantService.getReviewSummary(restaurantDTO);

	}

}