<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:authentication property="principal.memberNum" var="loginMemberNum" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동호회 채팅</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/common.css">

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="chat-wrap">

		<div class="chat-card">

			<div class="chat-header">

				<div>
				<div class="chat-room-badge">
	CLUB CHAT
</div>
					<h2 class="chat-title">${clubName}채팅방</h2>
					<p class="chat-desc">${clubName} 회원들과 자유롭게 대화해보세요.</p>
				</div>

				<a href="/club/detail?clubNum=${clubNum}" class="chat-back-btn">
					동호회로 돌아가기 </a>

			</div>

			<div id="chatArea" class="chat-area">

				<c:choose>

					<c:when test="${empty messageList}">

						<div class="empty-chat">
							아직 등록된 채팅이 없습니다.<br> 첫 메시지를 남겨보세요.
						</div>

					</c:when>

					<c:otherwise>

						<c:forEach items="${messageList}" var="msg" varStatus="status">

							<c:set var="prevMsg" value="${messageList[status.index - 1]}" />

							<c:set var="isCompact"
								value="${status.index gt 0 and prevMsg.senderNum eq msg.senderNum and prevMsg.chatTime eq msg.chatTime}" />

							<c:choose>
								<c:when test="${msg.senderNum eq loginMemberNum}">
									<div
										class="chat-message my-message ${isCompact ? 'compact' : ''}">
								</c:when>
								<c:otherwise>
									<div
										class="chat-message other-message ${isCompact ? 'compact' : ''}">
								</c:otherwise>
							</c:choose>

							<div class="chat-bubble">
								<div class="chat-writer">${msg.senderName}</div>
								<div class="chat-content">${msg.messageContents}</div>
								<div class="chat-time">${msg.chatTime}</div>
							</div>
			</div>

			</c:forEach>

			</c:otherwise>

			</c:choose>

		</div>

		<div class="chat-input-area">

			<input type="text" id="messageInput" class="form-control chat-input"
				placeholder="메시지를 입력하세요">

			<button type="button" id="sendBtn" class="btn chat-send-btn">

				전송</button>

		</div>

	</div>

	</div>

	<script>
		const clubNum = "${clubNum}";
		const loginMemberNum = "${loginMemberNum}";

		const socket = new WebSocket("ws://" + location.host
				+ "/ws/clubChat?clubNum=" + clubNum);

		const chatArea = document.getElementById("chatArea");
		const messageInput = document.getElementById("messageInput");
		const sendBtn = document.getElementById("sendBtn");

		socket.onmessage = function(event) {

			const emptyChat = document.querySelector(".empty-chat");

			if (emptyChat) {
				emptyChat.remove();
			}

			const data = JSON.parse(event.data);

			const div = document.createElement("div");

			const lastMessage = chatArea
					.querySelector(".chat-message:last-child");
			let isCompact = false;

			if (lastMessage) {
				const lastSenderNum = lastMessage.dataset.senderNum;
				const lastChatTime = lastMessage.dataset.chatTime;

				if (String(lastSenderNum) === String(data.memberNum)
						&& String(lastChatTime) === String(data.chatTime)) {
					isCompact = true;
				}
			}

			if (String(data.memberNum) === String(loginMemberNum)) {
				div.className = "chat-message my-message";
			} else {
				div.className = "chat-message other-message";
			}

			if (isCompact) {
				div.classList.add("compact");
			}

			div.dataset.senderNum = data.memberNum;
			div.dataset.chatTime = data.chatTime;

			div.innerHTML = '<div class="chat-bubble">'
					+ '<div class="chat-writer">' + data.senderName + '</div>'
					+ '<div class="chat-content">' + data.messageContents
					+ '</div>' + '<div class="chat-time">' + data.chatTime
					+ '</div>' + '</div>';

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

				/* alert("메시지를 입력해주세요."); */

				messageInput.focus();

				return;
			}

			socket.send(message);

			messageInput.value = "";

			messageInput.focus();
		}

		chatArea.scrollTop = chatArea.scrollHeight;
	</script>

</body>
</html>