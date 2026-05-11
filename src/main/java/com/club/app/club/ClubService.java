package com.club.app.club;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
