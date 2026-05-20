function deleteChat(chatroomNum) {

    if (!confirm("채팅방을 삭제하시겠습니까?")) return;

    location.href = "/productChat/delete?chatroomNum=" + chatroomNum;
}

/* =========================
   실시간 목록 업데이트 (웹소켓)
========================= */
let listSocket;

function connectListSocket() {

    listSocket = new WebSocket(
        "ws://" + location.host + "/ws/productChat?chatroomNum=list"
    );

    listSocket.onmessage = function(event) {
        
        const msg = JSON.parse(event.data);
        
        if (msg.type === "read") {
            // 읽음 처리 시 목록 배지 업데이트 (필요 시)
            updateUnreadBadge(msg.chatroomNum, 0);
            return;
        }

        updateRoomItem(msg);
    };

    listSocket.onclose = function() {
        setTimeout(connectListSocket, 2000);
    };
}

function updateRoomItem(msg) {

    const roomEl = document.getElementById("room-" + msg.chatroomNum);
    
    if (!roomEl) return; // 목록에 없는 방이면 무시 (또는 새로고침 유도)

    // 1. 마지막 메시지 업데이트
    const lastMsgEl = roomEl.querySelector(".last-message");
    if (lastMsgEl) lastMsgEl.innerText = msg.messageContent;

    // 2. 시간 업데이트
    const timeEl = roomEl.querySelector(".last-time");
    if (timeEl) {
        timeEl.innerText = formatTime(msg.createtime);
        timeEl.dataset.time = msg.createtime;
    }

    // 3. 안읽은 메시지 카운트 업데이트
    if (Number(msg.senderNum) !== Number(loginUserNum)) {
        
        const badgeContainer = roomEl.querySelector(".badge-container");
        let badge = badgeContainer.querySelector(".unread-badge");
        
        if (!badge) {
            badge = document.createElement("div");
            badge.classList.add("unread-badge");
            badge.innerText = "0";
            badgeContainer.appendChild(badge);
        }
        
        badge.innerText = Number(badge.innerText) + 1;
    }

    // 4. 맨 위로 이동
	const container = document.getElementById("chatList");
	container.prepend(roomEl);
}

function updateUnreadBadge(chatroomNum, count) {
    const roomEl = document.getElementById("room-" + chatroomNum);
    if (!roomEl) return;
    
    const badge = roomEl.querySelector(".unread-badge");
    if (badge) {
        if (count <= 0) {
            badge.remove();
        } else {
            badge.innerText = count;
        }
    }
}

function formatTime(time) {
    if (!time) return "";
    
    if (typeof time === "string") {
        time = time.split(".")[0];
        const [date, t] = time.split("T");
        if (t) {
            const [h, m] = t.split(":");
            return h + ":" + m;
        }
    }
    
    let d = new Date(time);
    if (!isNaN(d.getTime())) {
        return String(d.getHours()).padStart(2, '0') + ":" + String(d.getMinutes()).padStart(2, '0');
    }
    return "";
}

// 초기 연결
window.addEventListener("DOMContentLoaded", connectListSocket);