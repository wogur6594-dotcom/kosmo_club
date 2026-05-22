package com.club.app.club.chat;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClubMessageDTO {

	private String messageType;
	private String imageUrl;
	private String chatTime;
	private Long messageNum;
	private Long clubNum;
	private Long senderNum;
	private String senderName;
	private String messageContents;
	private String clubName;
	private LocalDateTime createDate;
}