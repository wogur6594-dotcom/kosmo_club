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
}

.other-name {
	font-size: 13px;
	color: gray;
}
</style>

</head>

<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	<div class="chat-container">
		<div class="header">내 채팅</div>
		<c:if test="${not empty msg}">
			<div class="alert alert-danger alert-dismissible fade show mt-2" role="alert">
				${msg}
				<button type="button" class="close" data-dismiss="alert">
					<span>&times;</span>
				</button>
			</div>
		</c:if>
		<c:forEach items="${list}" var="c">
			<a class="chat-item" href="/productChat/detail?chatroomNum=${c.chatroomNum}">
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
					<div class="product-name">${c.productName}</div>
					<div class="other-name">${c.otherName}</div>
				</div>
				<button class="btn btn-sm btn-danger" onclick="event.preventDefault(); deleteChat(${c.chatroomNum});">삭제</button>
			</a>
		</c:forEach>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/productChat/list.js"></script>
</body>
</html>