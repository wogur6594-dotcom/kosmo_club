package com.club.app.club.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.S3Service;
import com.club.app.pager.Pager;

@Service
public class ClubBoardService {

	@Autowired
	private ClubFileMapper clubFileMapper;

	@Autowired
	private S3Service s3Service;

	@Autowired
	private ClubBoardMapper clubBoardMapper;

	public List<ClubBoardDTO> clubBoardList(Pager pager) throws Exception {

		Long totalCount = clubBoardMapper.getClubBoardCount(pager);

		pager.setTotalCount(totalCount);

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

			boolean checkMain = false;

			for (MultipartFile mf : clubBoardDTO.getAttaches()) {

				if (mf.isEmpty()) {
					continue;
				}

				String fileName = s3Service.upload(mf, "clubBoard");

				ClubFileDTO clubFileDTO = new ClubFileDTO();

				clubFileDTO.setBoardNum(clubBoardDTO.getBoardNum());
				clubFileDTO.setFileName(fileName);
				clubFileDTO.setOriName(mf.getOriginalFilename());

				if (!checkMain) {
					clubFileDTO.setIsMain(true);
					checkMain = true;
				} else {
					clubFileDTO.setIsMain(false);
				}

				clubFileMapper.addFile(clubFileDTO);
			}
		}

		return result;
	}

	public int update(ClubBoardDTO clubBoardDTO) throws Exception {

		int result = clubBoardMapper.update(clubBoardDTO);

		if (clubBoardDTO.getAttaches() != null) {

			for (MultipartFile mf : clubBoardDTO.getAttaches()) {

				if (mf.isEmpty()) {
					continue;
				}

				String fileName = s3Service.upload(mf, "clubBoard");

				ClubFileDTO clubFileDTO = new ClubFileDTO();

				clubFileDTO.setBoardNum(clubBoardDTO.getBoardNum());
				clubFileDTO.setFileName(fileName);
				clubFileDTO.setOriName(mf.getOriginalFilename());
				clubFileDTO.setIsMain(false);

				clubFileMapper.addFile(clubFileDTO);
			}
		}

		return result;
	}

	public int delete(ClubBoardDTO clubBoardDTO) throws Exception {
		ClubBoardDTO detail = this.detail(clubBoardDTO);
		if(detail != null && detail.getList() != null){
			for(ClubFileDTO file : detail.getList()){
				s3Service.delete(file.getFileName());
			}
		}
		return clubBoardMapper.delete(clubBoardDTO);
	}

	public List<ClubBoardDTO> getBoardListByClubNum(Long clubNum) throws Exception {
		return clubBoardMapper.clubBoardListByClubNum(clubNum);
	}

	public List<ClubBoardDTO> noticeList(Long clubNum) throws Exception {
		return clubBoardMapper.noticeList(clubNum);
	}

	public List<ClubBoardDTO> myBoardList(ClubBoardDTO clubBoardDTO) throws Exception {
		return clubBoardMapper.myBoardList(clubBoardDTO);
	}

	public int hitUpdate(Long boardNum) throws Exception {
		return clubBoardMapper.hitUpdate(boardNum);
	}

	public List<ClubBoardDTO> popularList(Long clubNum) throws Exception {
		return clubBoardMapper.popularList(clubNum);
	}

}