<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.notification-box {
	max-width: 850px;
	margin: 50px auto;
	background-color: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.page-title {
	font-weight: 800;
	color: #3f2d20;
	margin-bottom: 30px;
}

.notification-item {
	padding: 18px;
	border-radius: 14px;
	margin-bottom: 15px;
	transition: 0.2s;
}

.notification-item:hover {
	background-color: #fff5ed;
}

.notification-link {
	text-decoration: none;
	color: #3f2d20;
	display: block;
}

.notification-link:hover {
	text-decoration: none;
	color: #3f2d20;
}

.notification-date {
	font-size: 13px;
	color: #999;
	margin-top: 8px;
}

.empty-text {
	text-align: center;
	padding: 50px;
	color: #999;
	font-size: 18px;
}

.unread-badge {
	background-color: #ff6f0f;
	color: white;
	font-size: 12px;
	padding: 4px 8px;
	border-radius: 10px;
	margin-left: 8px;
}

.unread-notification {
	background-color: #fffdfb;
	border: 1px solid #ffb27a;
}

.read-notification {
	background-color: #f7f3ef;
	border: 1px solid #e5ded8;
	opacity: 0.75;
}
</style>

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container">

		<div class="notification-box">

			<h2 class="page-title">🔔 알림 목록</h2>

			<c:if test="${empty list}">

				<div class="empty-text">도착한 알림이 없습니다.</div>

			</c:if>

			<c:forEach items="${list}" var="dto">

				<div
					class="notification-item ${dto.isRead ? 'read-notification' : 'unread-notification'}">

					<a class="notification-link"
						href="/notification/read?notificationNum=${dto.notificationNum}&url=${dto.notificationUrl}">

						<div>

							${dto.notificationContents}

							<c:if test="${!dto.isRead}">
								<span class="unread-badge"> NEW </span>
							</c:if>

						</div>

						<div class="notification-date">${dto.formatDate}</div>

					</a>

				</div>

			</c:forEach>

		</div>

	</div>

</body>
</html>