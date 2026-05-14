<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동호회 채팅</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.chat-box {
	max-width: 800px;
	margin: 50px auto;
	background: white;
	border-radius: 18px;
	padding: 30px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.chat-area {
	height: 400px;
	overflow-y: auto;
	border: 1px solid #e0d4c8;
	border-radius: 12px;
	padding: 15px;
	background-color: #fffaf7;
}

.chat-input-area {
	display: flex;
	gap: 10px;
	margin-top: 15px;
}

.btn-brown {
	background-color: #8b5e3c;
	color: white;
	border-radius: 10px;
}

.btn-brown:hover {
	color: white;
	background-color: #6f472b;
}

.chat-time {
	font-size: 12px;
	color: #999;
	margin-left: 6px;
}
</style>
</head>
<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="chat-box">

		<h3 class="mb-4">동호회 채팅</h3>

		<div id="chatArea" class="chat-area">


			<c:forEach items="${messageList}" var="msg">

				<div class="chat-message">

					<strong>${msg.senderName}</strong> : ${msg.messageContents} <span
						class="chat-time"> (${msg.chatTime}) </span>

				</div>

			</c:forEach>


		</div>

		<div class="chat-input-area">
			<input type="text" id="messageInput" class="form-control"
				placeholder="메시지를 입력하세요">

			<button type="button" id="sendBtn" class="btn btn-brown">전송
			</button>
		</div>

		<div class="mt-3">
			<a href="/club/detail?clubNum=${clubNum}"
				class="btn btn-secondary btn-sm"> 동호회로 돌아가기 </a>
		</div>

	</div>

	<script>
		const clubNum = "${clubNum}";
		const socket = new WebSocket("ws://" + location.host
				+ "/ws/clubChat?clubNum=" + clubNum);

		const chatArea = document.getElementById("chatArea");
		const messageInput = document.getElementById("messageInput");
		const sendBtn = document.getElementById("sendBtn");

		socket.onmessage = function(event) {
			const div = document.createElement("div");
			div.className = "chat-message";
			div.innerHTML = event.data;
			chatArea.appendChild(div);
			chatArea.scrollTop = chatArea.scrollHeight;
		};

		sendBtn.addEventListener("click", function() {
			sendMessage();
		});

		messageInput.addEventListener("keydown", function(e) {
			if (e.key === "Enter") {
				sendMessage();
			}
		});

		function sendMessage() {
			const message = messageInput.value.trim();

			if (message === "") {
				return;
			}

			socket.send(message);
			messageInput.value = "";
		}

		chatArea.scrollTop = chatArea.scrollHeight;
	</script>

</body>
</html>