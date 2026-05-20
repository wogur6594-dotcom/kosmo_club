<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>채팅 목록</title>
<style>
body {
	margin: 0;
	font-family: Arial;
	background: #f5f5f5;
}

.chat-container {
	max-width: 700px;
	margin: 0 auto;
	background: white;
	min-height: 100vh;
}

.header {
	padding: 20px;
	font-size: 20px;
	font-weight: bold;
	border-bottom: 1px solid #ddd;
}

.chat-item {
	padding: 15px;
	border-bottom: 1px solid #eee;
	display: flex;
	align-items: center;
	gap: 10px;
	text-decoration: none;
	color: black;
}

.chat-item:hover {
	background: #f9f9f9;
}

.thumb {
	width: 50px;
	height: 50px;
	border-radius: 8px;
	object-fit: cover;
	background: #ddd;
}

.info {
	flex: 1;
}

.product-name {
	font-weight: bold;
	font-size: 13px;
	color: #007bff;
	margin-bottom: 2px;
}

.last-message {
	font-size: 13px;
	color: #666;
	margin-top: 2px;
	display: -webkit-box;
	-webkit-line-clamp: 1;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

.other-name {
	font-size: 15px;
	font-weight: bold;
	color: black;
}

.meta-info {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	gap: 5px;
}

.last-time {
	font-size: 11px;
	color: #999;
}

.unread-badge {
	background: #ff4d4f;
	color: white;
	font-size: 11px;
	font-weight: bold;
	padding: 2px 6px;
	border-radius: 10px;
	min-width: 18px;
	text-align: center;
}
</style>

</head>

<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	<div class="chat-container">
		<div class="header">내 채팅</div>
		<div id="chatList">
			<c:if test="${not empty msg}">
				<div class="alert alert-danger alert-dismissible fade show mt-2" role="alert">
					${msg}
					<button type="button" class="close" data-dismiss="alert">
						<span>&times;</span>
					</button>
				</div>
			</c:if>
			<c:forEach items="${list}" var="c">
				<a id="room-${c.chatroomNum}" class="chat-item" href="/productChat/detail?chatroomNum=${c.chatroomNum}">
					<c:set var="profileImg" value="${c.otherProfileImage}" />
					<c:choose>
						<c:when test="${empty profileImg}">
							<img class="thumb" src="/image/default.png">
						</c:when>
						<c:otherwise>
							<img class="thumb" src="/files/memberProfile/${profileImg}" onerror="this.src='/image/default.png'">
						</c:otherwise>
					</c:choose>
					<div class="info">
						<div class="product-name">
							<i class="bi bi-box-seam"></i> ${c.productName}
						</div>
						<div class="other-name">${c.otherName}</div>
						<div class="last-message">
							<c:choose>
								<c:when test="${empty c.lastMessage}">대화를 시작해보세요!</c:when>
								<c:otherwise>${c.lastMessage}</c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="meta-info">
						<div class="last-time" data-time="${c.lastMessageTime != null ? c.lastMessageTime : c.createtime}"></div>
						<div class="badge-container">
							<c:if test="${c.unreadCount > 0}">
								<div class="unread-badge">${c.unreadCount}</div>
							</c:if>
						</div>
						<button class="btn btn-sm btn-danger mt-1" style="font-size: 10px; padding: 1px 5px;" onclick="event.preventDefault(); deleteChat(${c.chatroomNum});">삭제</button>
					</div>
				</a>
			</c:forEach>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script>
		const loginUserNum = "${loginUser.memberNum}";
	</script>
	<script src="/js/productChat/list.js"></script>
	<script>
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

		document.querySelectorAll(".last-time").forEach(el => {
			const raw = el.dataset.time;
			if (raw) {
				el.innerText = formatTime(raw);
			}
		});
	</script>
</body>
</html>
