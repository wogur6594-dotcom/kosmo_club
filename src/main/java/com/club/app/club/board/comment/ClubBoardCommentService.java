package com.club.app.club.board.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClubBoardCommentService {

	@Autowired
	private ClubBoardCommentMapper clubBoardCommentMapper;

	public List<ClubBoardCommentDTO> list(Long boardNum) throws Exception {

		return clubBoardCommentMapper.list(boardNum);

	}

	public int add(ClubBoardCommentDTO clubBoardCommentDTO) throws Exception {

		return clubBoardCommentMapper.add(clubBoardCommentDTO);

	}

	public int delete(Long commentNum) throws Exception {

		return clubBoardCommentMapper.delete(commentNum);

	}

}