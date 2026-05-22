package com.club.app.product;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.member.MemberDTO;
import com.club.app.member.MemberService;
import com.club.app.pager.ProductPager;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	private ProductService productService;

	@Autowired
	private com.club.app.productChat.ChatService chatService;

	@Autowired
	private MemberService memberService;

	// 리스트
	@GetMapping("list")
	public String list(ProductPager pager, Model model) throws Exception {
		List<ProductDTO> li = productService.list(pager);
		model.addAttribute("list", li);
		model.addAttribute("pager", pager);
		return "product/list";
	}

	// 등록 페이지
	@GetMapping("add")
	public String addForm(Model model) {
		model.addAttribute("productDTO", new ProductDTO());
		return "product/add";
	}

	// 등록 처리
	@PostMapping("add")
	public String add(@Valid ProductDTO productDTO, BindingResult bindingResult,
			@RequestParam("attachs") MultipartFile[] attachs, Authentication auth) throws Exception {

		if (bindingResult.hasErrors()) {
			return "product/add";
		}

		if (attachs.length > 10) {
			bindingResult.rejectValue("attachs", "file.limit", "파일은 최대 10개까지 업로드 가능합니다.");
		}

		MemberDTO memberDTO = (MemberDTO) auth.getPrincipal();

		productDTO.setMemberNum(memberDTO.getMemberNum());

		productService.add(productDTO);

		return "redirect:./list";
	}

	@GetMapping("detail")
	public String detail(@ModelAttribute ProductDTO productDTO, Model model, Authentication auth) throws Exception {

		ProductDTO dto = productService.detail(productDTO);
		int chatCount = chatService.countByProductNum(productDTO.getProductNum());

		model.addAttribute("loginUser", auth.getPrincipal());
		model.addAttribute("product", dto);
		model.addAttribute("chatCount", chatCount);

		return "product/detail";
	}

	@GetMapping("edit")
	public String editForm(ProductDTO productDTO, Authentication auth, Model model) throws Exception {

		ProductDTO product = productService.detail(productDTO);

		// auth에서 바로 꺼내기
		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		Long loginMemberNum = loginUser.getMemberNum();

		// 권한 체크
		if (!Objects.equals(product.getMemberNum(), loginMemberNum)) {
			throw new AccessDeniedException("수정 권한 없음");
		}

		model.addAttribute("productDTO", product);
		model.addAttribute("product", product); // Carousel 등 기존 참조 유지

		return "product/edit";
	}

	@PostMapping("edit")
	public String edit(@Valid @ModelAttribute("productDTO") ProductDTO productDTO, BindingResult bindingResult,
			Authentication auth, Model model) throws Exception {

		if (bindingResult.hasErrors()) {
			// 데이터 재조회 (파일 목록 등을 위해)
			ProductDTO product = productService.detail(productDTO);
			model.addAttribute("product", product);
			return "product/edit";
		}

		// 로그인 유저
		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		// 기존 데이터 조회 (권한 체크용)
		ProductDTO product = productService.detail(productDTO);

		if (!Objects.equals(product.getMemberNum(), loginUser.getMemberNum())) {
			throw new AccessDeniedException("수정 권한 없음");
		}

		// 상품 정보 수정
		productService.edit(productDTO);

		// 이미지 추가 처리 (있으면)
		if (productDTO.getAttachs() != null) {

			for (MultipartFile file : productDTO.getAttachs()) {

				if (file.isEmpty())
					continue;

				productService.addFile(file, productDTO.getProductNum());
			}
		}

		return "redirect:/product/detail?productNum=" + productDTO.getProductNum();
	}

	@PostMapping("/addFile")
	@ResponseBody
	public ProductDTO addFile(@RequestParam("file") MultipartFile[] files, ProductDTO productDTO) throws Exception {

		Long productNum = productDTO.getProductNum();

		for (MultipartFile file : files) {

			if (file.isEmpty())
				continue;

			productService.addFile(file, productNum);
		}

		return productService.detail(productDTO);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public String deleteFile(@RequestParam("fileNum") Long fileNum) throws Exception {

		int result = productService.deleteFile(fileNum);

		return (result > 0) ? "success" : "fail";
	}

	@PostMapping("delete")
	public String delete(ProductDTO productDTO, Authentication auth) throws Exception {

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		productService.delete(productDTO, loginUser.getMemberNum());

		return "redirect:/product/list";
	}

	@GetMapping("myList")
	public String myList() throws Exception {
		return "product/myList";
	}

	@GetMapping("myListAjax")
	public String myListAjax(ProductPager pager, Authentication auth, Model model) throws Exception {

		MemberDTO member = (MemberDTO) auth.getPrincipal();
		pager.setMemberNum(member.getMemberNum());

		long perPage = 9;
		pager.setPerPage(perPage);

		// ⭐ 핵심 수정 1: page null / 0 방어
		long page = pager.getPage();

		if (page < 1) {
			page = 1;
		}

		// ⭐ 핵심 수정 2: OFFSET 정확 계산 (1-based 기준)
		pager.setStartNum((page - 1) * perPage);

		List<ProductDTO> list = productService.myList(pager);

		model.addAttribute("list", list);

		return "product/myListItem";
	}

}
