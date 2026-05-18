let socket = new WebSocket(
    "ws://localhost:80/ws/productChat?chatroomNum=" + chatroomNum
);

socket.onopen = function() {
    console.log("채팅 연결 성공");
};

socket.onmessage = function(event) {
    let msg = JSON.parse(event.data);
    renderMessage(msg);
};

function sendMessage() {

    let message = document.getElementById("message").value;

    if (!message.trim()) return;

    let data = {
        chatroomNum: Number(chatroomNum),
        messageContent: message
    };

    socket.send(JSON.stringify(data));

    document.getElementById("message").value = "";
}

function renderMessage(data) {

    let box = document.getElementById("chatBox");

    let div = document.createElement("div");

    div.classList.add("msg");

    if (Number(data.senderNum) === Number(loginUserNum)) {
        div.classList.add("me");
    } else {
        div.classList.add("other");
    }

    // 🔥 이름 + 메시지 같이 표시 (실시간용)
    div.innerHTML = `
        <div class="sender">${data.senderName ?? ""}</div>
        <div class="content">${data.messageContent}</div>
    `;

    box.appendChild(div);

    box.scrollTop = box.scrollHeight;
}

document.getElementById("message").addEventListener("keydown", function(e) {
    if (e.key === "Enter") {
        sendMessage();
    }
});

window.onload = function () {
    let box = document.getElementById("chatBox");
    box.scrollTop = box.scrollHeight;
};