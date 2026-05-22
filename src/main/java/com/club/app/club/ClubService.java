package com.club.app.club;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberMapper;
import com.club.app.file.FileDTO;
import com.club.app.file.S3Service;
import com.club.app.member.MemberDTO;
import com.club.app.pager.Pager;

@Service
public class ClubService {

	@Autowired
	private ClubMapper clubMapper;

	@Autowired
	private ClubMemberMapper clubMemberMapper;
	
	@Autowired
	private S3Service s3Service;

	public List<ClubDTO> list(Pager pager) throws Exception {

		pager.makePageNum(clubMapper.getCount(pager));
		pager.makeStartNum();

		return clubMapper.list(pager);
	}

	public ClubDTO detail(ClubDTO clubDTO) throws Exception {

		return clubMapper.detail(clubDTO);
	}

	@Transactional
	public int create(ClubDTO clubDTO, MultipartFile[] attaches, MemberDTO memberDTO) throws Exception {

		int result = clubMapper.create(clubDTO);

		// 동호회 만든 사람을 동호회장으로 등록
		ClubMemberDTO clubMemberDTO = new ClubMemberDTO();
		clubMemberDTO.setClubNum(clubDTO.getClubNum());
		clubMemberDTO.setMemberNum(memberDTO.getMemberNum());
		clubMemberDTO.setRoleNum(1L);

		clubMemberMapper.join(clubMemberDTO);

		for (MultipartFile multipartFile : attaches) {

			if (multipartFile.isEmpty()) {
				continue;
			}

			String fileName = s3Service.upload(multipartFile, "club");

			FileDTO fileDTO = new FileDTO();
			fileDTO.setFileName(fileName);
			fileDTO.setOriName(multipartFile.getOriginalFilename());
			fileDTO.setClubNum(clubDTO.getClubNum());

			clubMapper.createFile(fileDTO);
		}

		return result;
	}

	public Long isClubOwner(ClubDTO clubDTO) throws Exception {
		return clubMapper.isClubOwner(clubDTO);
	}

	public Long isAdmin(MemberDTO memberDTO) throws Exception {
		return clubMapper.isAdmin(memberDTO);
	}

	public int delete(ClubDTO clubDTO) throws Exception {
		ClubDTO detail = clubMapper.detail(clubDTO);
		if(detail != null && detail.getFileDTO() != null){
			s3Service.delete(detail.getFileDTO().getFileName());
		}
		return clubMapper.delete(clubDTO);
	}

	public List<ClubDTO> myClubList(ClubMemberDTO clubMemberDTO) throws Exception {
		return clubMapper.myClubList(clubMemberDTO);
	}

}
