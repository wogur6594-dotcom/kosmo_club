package com.club.app.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.member.MemberDTO;
import com.club.app.pager.ProductPager;

@Controller
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	private ProductService productService;

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
	public String addForm() {
		return "product/add";
	}

	// 등록 처리
	@PostMapping("add")
	public String add(ProductDTO productDTO, @RequestParam("attachs") MultipartFile[] attachs, Authentication auth)
			throws Exception {

		MemberDTO memberDTO = (MemberDTO) auth.getPrincipal();

		productDTO.setMemberNum(memberDTO.getMemberNum());

		productService.add(productDTO);

		return "redirect:./list";
	}

}
