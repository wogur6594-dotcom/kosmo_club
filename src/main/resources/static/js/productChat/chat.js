let socket;
let messageQueue = [];

/* =========================
   연결
========================= */
function connectSocket() {

    socket = new WebSocket(
        "ws://localhost:80/ws/productChat?chatroomNum=" + chatroomNum
    );

    socket.onopen = function() {
        console.log("채팅 연결 성공");

        messageQueue.forEach(m => socket.send(JSON.stringify(m)));
        messageQueue = [];

        sendReadEvent();
    };

    socket.onmessage = function(event) {

        let msg = JSON.parse(event.data);

        // =========================
        // read 이벤트
        // =========================
        if (msg.type === "read") {
            // 내가 보낸 read 이벤트가 아닐 때만 UI 업데이트
            if (Number(msg.senderNum) !== Number(loginUserNum)) {
                markAsReadUI();
            }
            return;
        }

        renderMessage(msg);
    };

    socket.onclose = function() {
        setTimeout(connectSocket, 2000);
    };
}

/* =========================
   메시지 전송
========================= */
function sendMessage() {

    let input = document.getElementById("message");

    if (!input.value.trim()) return;

    safeSend({
        type: "message",
        chatroomNum: Number(chatroomNum),
        messageContent: input.value
    });

    input.value = "";
}

/* =========================
   read 이벤트
========================= */
function sendReadEvent() {

    safeSend({
        type: "read",
        chatroomNum: Number(chatroomNum)
    });
}

/* =========================
   안전 전송
========================= */
function safeSend(data) {

    if (!socket || socket.readyState !== 1) {
        messageQueue.push(data);
        return;
    }

    socket.send(JSON.stringify(data));
}

/* =========================
   메시지 렌더링
========================= */
function renderMessage(data) {

    let box = document.getElementById("chatBox");

    let div = document.createElement("div");

    const isMe = Number(data.senderNum) === Number(loginUserNum);

    div.classList.add("msg");
    div.classList.add(isMe ? "me" : "other");

    const time = formatTime(data.createtime);

    div.innerHTML = `
        <div class="sender">${data.senderName ?? ""}</div>

        <div class="content">${data.messageContent ?? ""}</div>

        <div class="meta">
            <span class="time">${time}</span>

            ${isMe && !data.isRead
            ? `<span class="unread-badge">1</span>`
            : ``}
        </div>
    `;

    box.appendChild(div);
    scrollToBottom();
}

/* =========================
   read UI 처리
========================= */
function markAsReadUI() {

    document.querySelectorAll(".msg.me .unread-badge")
        .forEach(el => el.remove());
}

/* =========================
   시간
========================= */
function formatTime(time) {

    if (!time) return "";

    // LocalDateTime 안전 처리
    if (typeof time === "string") {

        // 1) 마이크로초 제거
        time = time.split(".")[0];

        // 2) T 기준 파싱
        const [date, t] = time.split("T");

        if (t) {
            const [h, m] = t.split(":");
            return `${h}:${m}`;
        }
    }

    let d = new Date(time);

    if (!isNaN(d.getTime())) {
        return String(d.getHours()).padStart(2, '0')
            + ":" +
            String(d.getMinutes()).padStart(2, '0');
    }

    return "";
}

function initMessageTimes() {

    document.querySelectorAll(".msg .time").forEach(el => {

        const raw = el.dataset.time;

        if (raw) {
            el.innerText = formatTime(raw);
        }
    });
}

function scrollToBottom() {

    let box = document.getElementById("chatBox");

    if (!box) return;

    requestAnimationFrame(() => {
        box.scrollTop = box.scrollHeight;
    });
}

/* =========================
   이벤트
========================= */
document.getElementById("message").addEventListener("keydown", e => {
    if (e.key === "Enter") sendMessage();
});

window.addEventListener("focus", sendReadEvent);

/* =========================
   시작
========================= */
window.onload = function() {

    connectSocket();

    // 🔥 JSP로 이미 렌더된 메시지 처리 후 스크롤
    setTimeout(() => {
		initMessageTimes();
        scrollToBottom();
    }, 0);
};