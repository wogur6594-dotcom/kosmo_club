package com.club.app.club.schedule;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ClubScheduleService {

	private final ClubScheduleMapper clubScheduleMapper;

	public List<ClubScheduleDTO> list(Long clubNum) throws Exception {
		return clubScheduleMapper.list(clubNum);
	}

	public ClubScheduleDTO detail(ClubScheduleDTO clubScheduleDTO) throws Exception {
		return clubScheduleMapper.detail(clubScheduleDTO);
	}

	public int create(ClubScheduleDTO clubScheduleDTO) throws Exception {
		return clubScheduleMapper.create(clubScheduleDTO);
	}

	public int delete(ClubScheduleDTO clubScheduleDTO) throws Exception {

		return clubScheduleMapper.delete(clubScheduleDTO);
	}

	public int update(ClubScheduleDTO clubScheduleDTO) throws Exception {

		return clubScheduleMapper.update(clubScheduleDTO);
	}

}