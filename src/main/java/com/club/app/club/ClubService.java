package com.club.app.club;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.pager.Pager;

@Service
public class ClubService {

	@Autowired
	private ClubMapper clubMapper;

	public List<ClubDTO> list(Pager pager) throws Exception {

		pager.makePageNum(clubMapper.getCount(pager));
		pager.makeStartNum();

		return clubMapper.list(pager);
	}

	public ClubDTO detail(ClubDTO clubDTO) throws Exception {

		return clubMapper.detail(clubDTO);
	}

	public int create(ClubDTO clubDTO) throws Exception {

		int result = clubMapper.create(clubDTO);

		return result;
	}
	
	public Long getCount(Pager pager) throws Exception {

		return clubMapper.getCount(pager);

	}

}
