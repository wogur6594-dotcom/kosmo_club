package com.club.app.club.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.club.app.pager.Pager;

@Service
public class ClubBoardService {

    @Autowired
    private ClubBoardMapper clubBoardMapper;

    public List<ClubBoardDTO> list(Pager pager) throws Exception {
        Long totalCount = clubBoardMapper.getCount(pager);
        pager.makePageNum(totalCount);
        pager.makeStartNum();

        return clubBoardMapper.list(pager);
    }

    public ClubBoardDTO detail(ClubBoardDTO clubBoardDTO) throws Exception {
        return clubBoardMapper.detail(clubBoardDTO);
    }

    public int create(ClubBoardDTO clubBoardDTO) throws Exception {
        return clubBoardMapper.create(clubBoardDTO);
    }

    public int update(ClubBoardDTO clubBoardDTO) throws Exception {
        return clubBoardMapper.update(clubBoardDTO);
    }

    public int delete(ClubBoardDTO clubBoardDTO) throws Exception {
        return clubBoardMapper.delete(clubBoardDTO);
    }
}