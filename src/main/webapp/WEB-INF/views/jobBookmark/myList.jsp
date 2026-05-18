<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관심 공고</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.bookmark-box {
	max-width: 1100px;
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

.job-card {
	border: 1px solid #f0e2d7;
	border-radius: 14px;
	padding: 20px;
	margin-bottom: 18px;
	transition: 0.2s;
	background-color: #fffdfa;
}

.job-card:hover {
	transform: translateY(-2px);
	box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
}

.job-title {
	font-size: 1.2rem;
	font-weight: 700;
	color: #3f2d20;
	text-decoration: none;
}

.job-title:hover {
	color: #ff6f0f;
	text-decoration: none;
}

.badge-soft {
	background-color: #ffe7cf;
	color: #c96a00;
	font-weight: 700;
	padding: 6px 10px;
	border-radius: 10px;
	font-size: 0.8rem;
}

.empty-box {
	text-align: center;
	padding: 80px 20px;
	color: #888;
	font-size: 1.1rem;
}
</style>

</head>
<body>

	<div class="container">

		<div class="bookmark-box">

			<h2 class="page-title">관심 공고</h2>

			<c:choose>

				<c:when test="${empty list}">

					<div class="empty-box">관심 등록한 공고가 없습니다.</div>

				</c:when>

				<c:otherwise>

					<c:forEach items="${list}" var="dto">

						<div class="job-card">

							<div
								class="d-flex justify-content-between align-items-center mb-2">

								<a href="/job/detail?jobNum=${dto.jobNum}" class="job-title">

									${dto.jobTitle} </a> <span class="badge-soft">
									${dto.jobCategory} </span>

							</div>

							<div class="text-muted mb-2">${dto.jobLocation} ·
								${dto.jobType}</div>

							<div class="font-weight-bold mb-2">${dto.jobPay}</div>

							<div class="text-muted">작성자 : ${dto.memberName}</div>

						</div>

					</c:forEach>

				</c:otherwise>

			</c:choose>

		</div>

	</div>

</body>
</html>