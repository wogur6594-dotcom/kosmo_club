package com.club.app.club.chat;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClubMessageService {

	private final ClubMessageMapper clubMessageMapper;

	public int insert(ClubMessageDTO clubMessageDTO) throws Exception {
		return clubMessageMapper.insert(clubMessageDTO);
	}

	public List<ClubMessageDTO> list(Long clubNum) throws Exception {
		return clubMessageMapper.list(clubNum);
	}
}