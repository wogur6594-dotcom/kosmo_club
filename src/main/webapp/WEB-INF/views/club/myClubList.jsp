<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 동호회</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.myclub-box {
	max-width: 1100px;
	margin: 50px auto;
}

.page-title {
	font-size: 30px;
	font-weight: 800;
	color: #3f2d20;
	margin-bottom: 30px;
}

.club-card {
	background: white;
	border-radius: 18px;
	overflow: hidden;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
	margin-bottom: 25px;
}

.club-img {
	width: 100%;
	height: 220px;
	object-fit: cover;
}

.club-body {
	padding: 24px;
}

.club-title {
	font-size: 24px;
	font-weight: 800;
	color: #3f2d20;
	text-decoration: none;
}

.club-title:hover {
	color: #b36200;
	text-decoration: none;
}

.club-meta {
	color: #868e96;
	margin-top: 10px;
}

.badge-category {
	background: #fff3e8;
	color: #ff6f0f;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
}

.member-open {
	color: #2b8a3e;
	font-weight: 700;
}

.member-full {
	color: #c92a2a;
	font-weight: 700;
}

.empty-box {
	background: white;
	padding: 70px;
	text-align: center;
	border-radius: 18px;
	color: #868e96;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}
</style>

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container myclub-box">

		<h1 class="page-title">내 동호회</h1>

		<div class="mb-4 text-right">
			<a href="${pageContext.request.contextPath}/clubboard/myBoardList"
				class="btn btn-sm btn-dark"> 내 게시글 </a>
		</div>

		<c:choose>

			<c:when test="${empty list}">

				<div class="empty-box">가입한 동호회가 없습니다.</div>

			</c:when>

			<c:otherwise>

				<div class="row">

					<c:forEach items="${list}" var="dto">

						<div class="col-lg-6">

							<div class="club-card">

								<c:if test="${not empty dto.fileDTO.fileName}">

									<img src="/files/club/${dto.fileDTO.fileName}" class="club-img">

								</c:if>

								<div class="club-body">

									<div class="d-flex justify-content-between align-items-center">

										<span class="badge-category"> ${dto.clubCategory} </span>

										<c:choose>

											<c:when test="${dto.currentMember ge dto.clubMax}">
												<span class="member-full"> 정원마감 </span>
											</c:when>

											<c:otherwise>
												<span class="member-open"> 모집중 </span>
											</c:otherwise>

										</c:choose>

									</div>

									<div class="mt-3">

										<a href="/club/detail?clubNum=${dto.clubNum}"
											class="club-title"> ${dto.clubName} </a>

									</div>

									<div class="club-meta">${dto.clubLocation}·회원
										${dto.currentMember} / ${dto.clubMax}</div>

								</div>

							</div>

						</div>

					</c:forEach>

				</div>

			</c:otherwise>

		</c:choose>

	</div>

</body>
</html>