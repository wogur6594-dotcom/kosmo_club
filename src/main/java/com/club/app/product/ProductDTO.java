package com.club.app.product;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.club.app.member.MemberDTO;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductDTO {

	private Long productNum;
	private Long memberNum;
	@NotBlank(message = "상품명을 입력하세요.")
	private String productTitle;
	@NotBlank(message = "상품 정보를 입력하세요.")
	private String productContent;
	@NotNull(message = "상품 가격을 입력하세요.")
	private Long productPrice;
	private LocalDateTime createtime;
	@NotBlank(message = "지역을 선택하세요.")
	private String productLocation;
	private String productStatus;
	private String productType;
	
	private MemberDTO member;
	private List<ProductFileDTO> fileList;
	private List<MultipartFile> attachs;
}
