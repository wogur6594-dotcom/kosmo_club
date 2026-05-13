package com.club.app.club.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.club.app.file.FileManager;

@Service
public class ClubFileService {

	@Autowired
	private FileManager fileManager;

	@Autowired
	private ClubFileMapper clubFileMapper;

	public void changeMainImage(Long boardNum, Long fileNum) throws Exception {

		clubFileMapper.resetMainImage(boardNum);

		clubFileMapper.setMainImage(fileNum);
	}

	public void deleteImage(Long fileNum) throws Exception {

		ClubFileDTO clubFileDTO = clubFileMapper.detailFile(fileNum);

		fileManager.fileDelete("clubboard", clubFileDTO.getFileName());

		clubFileMapper.deleteFile(fileNum);
	}
}