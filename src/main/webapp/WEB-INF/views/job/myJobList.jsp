<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 공고 관리</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.manage-box {
	max-width: 1050px;
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

.job-card {
	border: 1px solid #f1e0d2;
	border-radius: 14px;
	padding: 22px;
	margin-bottom: 18px;
	background-color: #fffaf7;
}

.job-title {
	font-size: 20px;
	font-weight: 800;
	color: #3f2d20;
	text-decoration: none;
}

.job-title:hover {
	color: #ff6f0f;
	text-decoration: none;
}

.meta {
	color: #868e96;
	font-size: 14px;
	margin-top: 8px;
}

.pay {
	font-weight: 800;
	margin-top: 8px;
	color: #212529;
}

.badge-open {
	background: #d3f9d8;
	color: #2b8a3e;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
}

.badge-closed {
	background: #ffe3e3;
	color: #c92a2a;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
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

.empty-box {
	text-align: center;
	color: #868e96;
	padding: 60px 0;
}
.btn-back {
	background-color: #f1ebe6;
	color: #5f4b3b;
	border-radius: 12px;
	font-weight: 800;
	padding: 8px 18px;
	border: none;
	transition: 0.2s;
}

.btn-back:hover {
	background-color: #e3d8ce;
	color: #3f2d20;
	text-decoration: none;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="manage-box">

		<h1 class="page-title">내 공고 관리</h1>
		

		<c:choose>
			<c:when test="${empty list}">
				<div class="empty-box">등록한 공고가 없습니다.</div>
			</c:when>

			<c:otherwise>
				<c:forEach items="${list}" var="dto">

					<div class="job-card">

						<div class="d-flex justify-content-between align-items-start">

							<div>
								<a
									href="${pageContext.request.contextPath}/job/detail?jobNum=${dto.jobNum}"
									class="job-title"> ${dto.jobTitle} </a>

								<div class="meta">${dto.jobLocation}·${dto.jobWorkDay} ·
									${dto.jobWorkTime}</div>

								<div class="pay">${dto.jobPay}</div>

								<div class="meta">지원자 ${dto.currentApplyMember} /
									${dto.jobMaxMember}</div>
							</div>
							<c:if test="${dto.applyCount gt 0}">

								<div class="meta mt-2">

									최근 지원자 : ${dto.recentApplicantName}

									<c:if test="${dto.applyCount gt 1}">
			외 ${dto.applyCount - 1}명
		</c:if>

								</div>

							</c:if>

							<div class="text-right">

								<c:choose>
									<c:when test="${dto.currentApplyMember ge dto.jobMaxMember}">
										<span class="badge-closed">모집완료</span>
									</c:when>

									<c:otherwise>
										<span class="badge-open">모집중</span>
									</c:otherwise>
								</c:choose>

								<div class="mt-3">
									<a
										href="${pageContext.request.contextPath}/jobApply/applicantList?jobNum=${dto.jobNum}"
										class="btn btn-sm btn-orange"> 지원자 보기 </a> <a
										href="${pageContext.request.contextPath}/job/update?jobNum=${dto.jobNum}"
										class="btn btn-sm btn-secondary"> 수정 </a>
								</div>

							</div>

						</div>

					</div>

				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		<div class="text-right mt-4">

	<a href="javascript:history.back();" class="btn btn-back">
		뒤로가기
	</a>

</div>

	</div>

</body>
</html>