function deleteChat(chatroomNum) {

    if (!confirm("채팅방을 삭제하시겠습니까?")) return;

    location.href = "/productChat/delete?chatroomNum=" + chatroomNum;
}