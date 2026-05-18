package com.club.app.club.board;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.club.app.club.ClubDTO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ClubBoardDTO {

	private Long commentCount;

	private Long fileCount;

	private String memberName;

	private ClubDTO clubDTO;

	private Long boardNum;

	private Long clubNum;

	private String boardTitle;

	private String boardContents;

	private LocalDateTime createDate;

	private String boardCategory;

	private String boardWriter;

	private List<ClubFileDTO> list;

	private MultipartFile[] attaches;

	private String clubName;

	private Long memberNum;

	private String memberId;

	private Long hit;
	
	private Long likeCount;


}