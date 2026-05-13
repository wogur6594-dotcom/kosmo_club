package com.club.app.club.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClubFileService {

	@Autowired
	private ClubFileMapper clubFileMapper;

	public void changeMainImage(Long boardNum, Long fileNum)
			throws Exception {

		clubFileMapper.resetMainImage(boardNum);

		clubFileMapper.setMainImage(fileNum);
	}
}