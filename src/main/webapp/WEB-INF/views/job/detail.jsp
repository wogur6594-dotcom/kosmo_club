<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알바 공고 상세</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
	color: #212529;
}

.detail-box {
	max-width: 820px;
	margin: 55px auto;
	background-color: white;
	border-radius: 18px;
	padding: 40px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.category-badge {
	display: inline-block;
	background-color: #fff3e8;
	color: #ff6f0f;
	font-size: 13px;
	font-weight: 700;
	padding: 6px 10px;
	border-radius: 6px;
	margin-bottom: 15px;
}

.detail-title {
	font-size: 30px;
	font-weight: 800;
	color: #1f2933;
	margin-bottom: 12px;
}

.detail-meta {
	color: #868e96;
	font-size: 14px;
	margin-bottom: 28px;
}

.info-card {
	background-color: #fffaf7;
	border: 1px solid #f1e0d2;
	border-radius: 14px;
	padding: 22px;
	margin-bottom: 28px;
}

.info-row {
	display: flex;
	margin-bottom: 12px;
}

.info-row:last-child {
	margin-bottom: 0;
}

.info-label {
	width: 90px;
	font-weight: 800;
	color: #5f4b3b;
}

.info-value {
	flex: 1;
	color: #212529;
}

.contents-box {
	line-height: 1.8;
	white-space: pre-wrap;
	font-size: 16px;
	margin-top: 20px;
	min-height: 180px;
}

.btn-orange {
	background-color: #ff6f0f;
	color: white;
	border-radius: 10px;
	font-weight: 700;
}

.btn-orange:hover {
	background-color: #e85f00;
	color: white;
}

.btn-soft {
	background-color: #f1f3f5;
	color: #343a40;
	border-radius: 10px;
	font-weight: 700;
}

.btn-soft:hover {
	background-color: #e9ecef;
	color: #212529;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="detail-box">

		<span class="category-badge">${dto.jobCategory}</span>

		<h1 class="detail-title">${dto.jobTitle}</h1>

		<!-- 썸네일 -->

		<c:if test="${not empty dto.fileName}">
			<div class="mb-4">
				<img src="/files/job/${dto.fileName}"
					style="width: 100%; border-radius: 16px;">
			</div>
		</c:if>


		<div class="detail-meta">${dto.memberName}·${dto.jobLocation}·
			${dto.createDateFormat}</div>

		<div class="info-card">

			<div class="info-row">
				<div class="info-label">급여</div>
				<div class="info-value">${dto.jobPay}</div>
			</div>

			<div class="info-row">
				<div class="info-label">근무요일</div>
				<div class="info-value">${dto.jobWorkDay}</div>
			</div>

			<div class="info-row">
				<div class="info-label">근무시간</div>
				<div class="info-value">${dto.jobWorkTime}</div>
			</div>

			<div class="info-row">
				<div class="info-label">근무지역</div>
				<div class="info-value">${dto.jobLocation}</div>
			</div>

		</div>

		<h5 class="font-weight-bold">상세 내용</h5>

		<div class="contents-box">${dto.jobContents}</div>

		<div class="text-right mt-4">

			<sec:authorize access="isAuthenticated()">

				<sec:authentication property="principal.memberNum"
					var="loginMemberNum" />

				<c:if test="${dto.memberNum eq loginMemberNum}">
					<a href="./update?jobNum=${dto.jobNum}" class="btn btn-orange">
						수정 </a>
				</c:if>

				<c:if test="${dto.memberNum eq loginMemberNum}">
					<form action="./delete" method="post" style="display: inline;">

						<input type="hidden" name="jobNum" value="${dto.jobNum}">

						<button type="submit" class="btn btn-danger"
							onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
					</form>
				</c:if>

				<sec:authorize access="hasRole('ADMIN')">
					<c:if test="${dto.memberNum ne loginMemberNum}">
						<form action="./delete" method="post" style="display: inline;">

							<input type="hidden" name="jobNum" value="${dto.jobNum}">

							<button type="submit" class="btn btn-danger"
								onclick="return confirm('관리자 권한으로 삭제하시겠습니까?');">삭제</button>
						</form>
					</c:if>
				</sec:authorize>

			</sec:authorize>

			<a href="./list" class="btn btn-soft">목록</a>

		</div>

	</div>

</body>
</html>