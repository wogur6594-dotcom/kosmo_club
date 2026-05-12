package com.club.app.club;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.FileDTO;
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

	public int create(ClubDTO clubDTO, MultipartFile[] attaches) throws Exception {

	    int result = clubMapper.create(clubDTO);

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

	public Long getCount(Pager pager) throws Exception {

		return clubMapper.getCount(pager);

	}

	// 테스트


}
