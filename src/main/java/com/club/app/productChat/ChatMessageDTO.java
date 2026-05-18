package com.club.app.productChat;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatMessageDTO {

    private Long messageNum;
    private Long chatroomNum;

    private Long senderNum;

    private String messageContent;

    private Boolean isRead = false;

    private LocalDateTime createtime;
    
    private String senderName;
    
    private String type; 
}
