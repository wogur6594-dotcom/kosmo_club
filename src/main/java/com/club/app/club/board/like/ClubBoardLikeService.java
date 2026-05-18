package com.club.app.club.board.like;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClubBoardLikeService {

	private final ClubBoardLikeMapper clubBoardLikeMapper;

	public int add(ClubBoardLikeDTO clubBoardLikeDTO) throws Exception {
		return clubBoardLikeMapper.add(clubBoardLikeDTO);
	}

	public int delete(ClubBoardLikeDTO clubBoardLikeDTO) throws Exception {
		return clubBoardLikeMapper.delete(clubBoardLikeDTO);
	}

	public int check(ClubBoardLikeDTO clubBoardLikeDTO) throws Exception {
		return clubBoardLikeMapper.check(clubBoardLikeDTO);
	}

	public int count(Long boardNum) throws Exception {
		return clubBoardLikeMapper.count(boardNum);
	}
}