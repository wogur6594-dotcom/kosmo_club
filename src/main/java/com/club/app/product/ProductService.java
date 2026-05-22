package com.club.app.product;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.FileManager;
import com.club.app.pager.ProductPager;

@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;

	@Autowired
	private com.club.app.file.S3Service s3Service;

	public int add(ProductDTO productDTO) throws Exception {

		int result = productMapper.add(productDTO);

		if (productDTO.getAttachs() != null) {

			for (MultipartFile mf : productDTO.getAttachs()) {

				// 빈 파일 제외
				if (mf.isEmpty()) {
					continue;
				}

				// 실제 파일 저장 (S3 사용)
				String fileName = s3Service.upload(mf, "product");

				// DTO 생성
				ProductFileDTO productFileDTO = new ProductFileDTO();

				productFileDTO.setProductNum(productDTO.getProductNum());
				productFileDTO.setFileName(fileName);
				productFileDTO.setOriName(mf.getOriginalFilename());

				// DB 저장
				productMapper.addFile(productFileDTO);
			}
		}

		return result;
	}

	public List<ProductDTO> list(ProductPager pager) throws Exception {

		if (pager.getProductType() == null) {
			pager.setProductType(new ArrayList<>());
		}

		if (pager.getProductLocation() == null) {
			pager.setProductLocation("");
		}

		Long totalCount = productMapper.getCount(pager);

		pager.setTotalCount(totalCount);
		pager.makePageNum(totalCount);
		pager.makeStartNum();

		return productMapper.list(pager);
	}

	public ProductDTO detail(ProductDTO productDTO) throws Exception {
		return productMapper.detail(productDTO);
	}

	public int edit(ProductDTO productDTO) throws Exception {

		// 1. 기존 데이터 조회
		ProductDTO origin = productMapper.detail(productDTO);

		// 3. 상태값 검증 (선택이지만 강력 추천)
		List<String> allowed = List.of("판매중", "거래중", "판매완료");

		if (!allowed.contains(productDTO.getProductStatus())) {
			throw new IllegalArgumentException("잘못된 상태값");
		}

		// 4. 업데이트
		return productMapper.edit(productDTO);
	}

	public int addFile(MultipartFile file, Long productNum) throws Exception {

		if (file == null || file.isEmpty()) {
			return 0;
		}
		// 1. 파일 저장 (S3Service 사용)
		String fileName = s3Service.upload(file, "product");
		// 2. DTO 생성
		ProductFileDTO dto = new ProductFileDTO();
		dto.setProductNum(productNum);
		dto.setFileName(fileName);
		dto.setOriName(file.getOriginalFilename());
		// 3. DB 저장
		return productMapper.addFile(dto);
	}

	public int deleteFile(Long fileNum) throws Exception {
		ProductFileDTO fileDTO = productMapper.getFileDetail(fileNum);
		if (fileDTO != null) {
			s3Service.delete(fileDTO.getFileName());
		}
		return productMapper.deleteFile(fileNum);
	}

	public void delete(ProductDTO productDTO, Long loginMemberNum) throws Exception {

		// 1. DB에서 상세 조회 (DTO 기반)
		ProductDTO product = productMapper.detail(productDTO);

		if (product == null) {
			throw new IllegalArgumentException("상품 없음");
		}

		// 2. 권한 체크 (edit과 동일 패턴)
		if (!Objects.equals(product.getMemberNum(), loginMemberNum)) {
			throw new AccessDeniedException("삭제 권한 없음");
		}

		// 3. S3 파일 삭제
		if (product.getFileList() != null) {
			for (ProductFileDTO f : product.getFileList()) {
				s3Service.delete(f.getFileName());
			}
		}

		// 4. 삭제 (cascade면 상품만 삭제)
		productMapper.delete(productDTO);
	}

	public List<ProductDTO> myList(ProductPager pager) throws Exception {

		if (pager.getProductType() == null) {
			pager.setProductType(new ArrayList<>());
		}

		if (pager.getProductLocation() == null) {
			pager.setProductLocation("");
		}

		if (pager.getSearch() == null) {
			pager.setSearch("");
		}

		return productMapper.myList(pager);
	}

}
