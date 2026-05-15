package com.club.app.notification;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NotificationDTO {

	private Long notificationNum;

	private Long memberNum;

	private String notificationContents;

	private String notificationUrl;

	private Boolean isRead;

	private LocalDateTime createDate;
	
	public String getFormatDate() {

	    if (createDate == null) {
	        return "";
	    }

	    return createDate.format(
	            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")
	    );
	}

}