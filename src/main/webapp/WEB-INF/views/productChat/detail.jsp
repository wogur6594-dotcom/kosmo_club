<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>채팅방</title>

<link rel="stylesheet" href="/css/chat.css">
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp" />

	<div class="container">

		<h3>
			<i class="bi bi-chat-dots"></i>
			${product.productTitle} 채팅방
			<a href="/product/detail?productNum=${product.productNum}" class="btn btn-sm btn-primary ml-2"> 상품보기 </a>
		</h3>
		<div class="chat-box" id="chatBox">
			<c:forEach items="${messages}" var="m">

				<div class="msg ${m.senderNum == loginUser.memberNum ? 'me' : 'other'}">

					<div class="sender">${m.senderName}</div>

					<div class="content">${m.messageContent}</div>

					<div class="meta">

						<span class="time" data-time="${m.createtime}"></span>

						<!-- 🔥 sender + unread -->
						<c:if test="${m.senderNum == loginUser.memberNum && !m.isRead}">
							<span class="unread-badge">1</span>
						</c:if>

					</div>

				</div>

			</c:forEach>
		</div>
		<!-- 입력 -->
		<div class="input-area">
			<input type="text" id="message" placeholder="메시지 입력">
			<button onclick="sendMessage()">전송</button>
		</div>
	</div>
	<!-- 🔥 JS 변수 전달 -->
	<script>
		const chatroomNum = "${chatroomNum}";
		const loginUserNum = "${loginUser.memberNum}";
	</script>

	<script src="/js/productChat/chat.js"></script>

</body>
</html>