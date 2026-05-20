package com.club.app.productChat;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatRoomDTO {

    private Long chatroomNum;
    private Long productNum;

    private Long buyerNum;
    private Long sellerNum;

    private LocalDateTime createtime;

    // 상품 정보 표시용
    private String productName;
    private String productThumbnail;

    // 상대방 정보
    private String otherName;
    
    private String otherProfileImage;

    // 마지막 메시지 정보
    private String lastMessage;
    private LocalDateTime lastMessageTime;

    // 안읽은 메시지 개수
    private Integer unreadCount;
}
