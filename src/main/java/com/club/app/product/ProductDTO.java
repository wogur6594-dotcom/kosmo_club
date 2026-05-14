package com.club.app.product;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.club.app.member.MemberDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductDTO {

	private Long productNum;
	private Long memberNum;
	private String productTitle;
	private String productContent;
	private Long productPrice;
	private LocalDateTime createtime;
	private String productLocation;
	private String productStatus;
	private String productType;
	
	private MemberDTO member;
	private List<ProductFileDTO> fileList;
	private List<MultipartFile> attachs;
}
