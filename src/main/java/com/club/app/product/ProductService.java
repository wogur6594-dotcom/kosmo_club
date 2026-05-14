package com.club.app.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.FileManager;
import com.club.app.pager.ProductPager;

@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private FileManager fileManager;

	public int add(ProductDTO productDTO) throws Exception {

		int result = productMapper.add(productDTO);

		if(productDTO.getAttachs() != null) {

			for(MultipartFile mf : productDTO.getAttachs()) {

				// 빈 파일 제외
				if(mf.isEmpty()) {
					continue;
				}

				// 실제 파일 저장
				String fileName = fileManager.fileSave("product", mf);

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
		pager.makePageNum(productMapper.getCount(pager));
		pager.makeStartNum();
		return productMapper.list(pager);
	}

	public ProductDTO detail(Long productId) throws Exception {
		return productMapper.detail(productId);
	}
}
