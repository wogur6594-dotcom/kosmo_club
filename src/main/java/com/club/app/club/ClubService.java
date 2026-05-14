package com.club.app.club;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.club.member.ClubMemberDTO;
import com.club.app.club.member.ClubMemberMapper;
import com.club.app.file.FileDTO;
import com.club.app.member.MemberDTO;
import com.club.app.pager.Pager;

@Service
public class ClubService {

	@Autowired
	private ClubMapper clubMapper;
	
	@Autowired
	private ClubMemberMapper clubMemberMapper;
	
	

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

	    String path = "C:/upload/club/";

	    File dir = new File(path);
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }

	    for (MultipartFile multipartFile : attaches) {

	        if (multipartFile.isEmpty()) {
	            continue;
	        }

	        String fileName = UUID.randomUUID().toString() + "_" + multipartFile.getOriginalFilename();

	        File file = new File(path, fileName);
	        multipartFile.transferTo(file);

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
		return clubMapper.delete(clubDTO);
	}



}
