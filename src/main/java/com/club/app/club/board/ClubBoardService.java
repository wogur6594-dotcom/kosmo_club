package com.club.app.club.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.FileManager;
import com.club.app.pager.Pager;

@Service
public class ClubBoardService {
	
	@Autowired
	private ClubFileMapper clubFileMapper;

	@Autowired
	private FileManager fileManager;

	@Autowired
	private ClubBoardMapper clubBoardMapper;

	public List<ClubBoardDTO> clubBoardList(Pager pager) throws Exception {

	    Long totalCount = clubBoardMapper.getCount(pager);

	    pager.makePageNum(totalCount);
	    pager.makeStartNum();

	    return clubBoardMapper.clubBoardList(pager);
	}


	public ClubBoardDTO detail(ClubBoardDTO clubBoardDTO) throws Exception {

		clubBoardDTO = clubBoardMapper.detail(clubBoardDTO);

		clubBoardDTO.setList(clubFileMapper.getFiles(clubBoardDTO));

		return clubBoardDTO;
	}

	public int create(ClubBoardDTO clubBoardDTO) throws Exception {

		int result = clubBoardMapper.create(clubBoardDTO);

		if (clubBoardDTO.getAttaches() != null) {

			for (MultipartFile mf : clubBoardDTO.getAttaches()) {

				if (mf.isEmpty()) {
					continue;
				}

				String fileName = fileManager.fileSave("clubboard", mf);

				ClubFileDTO clubFileDTO = new ClubFileDTO();

				clubFileDTO.setBoardNum(clubBoardDTO.getBoardNum());
				clubFileDTO.setFileName(fileName);
				clubFileDTO.setOriName(mf.getOriginalFilename());

				clubFileMapper.addFile(clubFileDTO);
			}
		}

		return result;
	}

	public int update(ClubBoardDTO clubBoardDTO) throws Exception {
		return clubBoardMapper.update(clubBoardDTO);
	}

	public int delete(ClubBoardDTO clubBoardDTO) throws Exception {
		return clubBoardMapper.delete(clubBoardDTO);
	}

	public List<ClubBoardDTO> getBoardListByClubNum(Long clubNum) throws Exception {
		return clubBoardMapper.clubBoardListByClubNum(clubNum);
	}
}