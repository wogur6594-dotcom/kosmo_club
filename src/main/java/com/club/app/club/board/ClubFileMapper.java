package com.club.app.club.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ClubFileMapper {

	public int addFile(ClubFileDTO clubFileDTO) throws Exception;

	public List<ClubFileDTO> getFiles(ClubBoardDTO clubBoardDTO) throws Exception;

	public int resetMainImage(Long boardNum) throws Exception;

	public int setMainImage(Long fileNum) throws Exception;

	public ClubFileDTO detailFile(Long fileNum) throws Exception;

	public int deleteFile(Long fileNum) throws Exception;

}