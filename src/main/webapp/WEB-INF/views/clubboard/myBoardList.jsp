<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 동호회 게시글</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.board-box {
	max-width: 950px;
	margin: 50px auto;
	background: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.page-title {
	font-size: 28px;
	font-weight: 800;
	color: #3f2d20;
	margin-bottom: 30px;
}

.board-card {
	border: 1px solid #f1e0d2;
	border-radius: 14px;
	padding: 20px;
	margin-bottom: 16px;
	background-color: #fffaf7;
}

.board-title {
	font-size: 19px;
	font-weight: 800;
	color: #3f2d20;
	text-decoration: none;
}

.board-title:hover {
	color: #b36200;
	text-decoration: none;
}

.meta {
	color: #868e96;
	font-size: 14px;
	margin-top: 8px;
}

.badge-category {
	background: #fff3e8;
	color: #ff6f0f;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
}

.empty-box {
	text-align: center;
	color: #868e96;
	padding: 60px 0;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="board-box">

		<h1 class="page-title">내 동호회 게시글</h1>

		<c:choose>
			<c:when test="${empty list}">
				<div class="empty-box">작성한 동호회 게시글이 없습니다.</div>
			</c:when>

			<c:otherwise>
				<c:forEach items="${list}" var="dto">

					<div class="board-card">

						<div class="d-flex justify-content-between align-items-center">

							<span class="badge-category"> ${dto.boardCategory} </span> <span
								class="meta"> ${dto.clubName} </span>

						</div>

						<div class="mt-3">
							<a
								href="${pageContext.request.contextPath}/clubboard/detail?boardNum=${dto.boardNum}&clubNum=${dto.clubNum}"
								class="board-title"> ${dto.boardTitle} </a>
						</div>

						<div class="meta">작성일 ${dto.createDate}</div>

					</div>

				</c:forEach>
			</c:otherwise>
		</c:choose>

	</div>

</body>
</html>