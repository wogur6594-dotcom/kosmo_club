package com.club.app.product;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.club.app.pager.ProductPager;

@Mapper
public interface ProductMapper {

	public int add(ProductDTO productDTO) throws Exception;

	public int addFile(ProductFileDTO productFileDTO) throws Exception;

	public List<ProductDTO> list(ProductPager pager) throws Exception;

	public Long getCount(ProductPager pager) throws Exception;

	public ProductDTO detail(ProductDTO productDTO) throws Exception;

	public int edit(ProductDTO productDTO) throws Exception;

	public int deleteFile(Long fileNum) throws Exception;

	public ProductFileDTO getFileDetail(Long fileNum) throws Exception;

	public void delete(ProductDTO productDTO) throws Exception;

	public List<ProductDTO> myList(ProductPager pager);

}