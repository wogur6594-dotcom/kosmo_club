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

<link rel="stylesheet" href="/css/job.css">
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="bookmark-box">

		<div class="manage-head">
			<div>
				<h1 class="page-title">관심 공고</h1>
				<p class="manage-desc">관심 등록한 동네알바 공고를 확인할 수 있습니다.</p>
			</div>

			<div class="manage-head-btns">
				<a href="${pageContext.request.contextPath}/jobApply/myList"
					class="btn-back-link"> 뒤로가기 </a>
			</div>
		</div>

		<c:choose>

			<c:when test="${empty list}">
				<div class="empty-box">관심 등록한 공고가 없습니다.</div>
			</c:when>

			<c:otherwise>

				<c:forEach items="${list}" var="dto">

					<div class="bookmark-card">

						<div class="bookmark-card-main">

							<a
								href="${pageContext.request.contextPath}/job/detail?jobNum=${dto.jobNum}"
								class="job-title"> ${dto.jobTitle} </a>

							<div class="meta">${dto.jobLocation} · ${dto.jobType}</div>

							<div class="pay">${dto.jobPay}</div>

							<div class="meta">작성자 : ${dto.memberName}</div>

						</div>

						<div class="bookmark-card-side">
							<span class="badge-soft">${dto.jobCategory}</span>
						</div>

					</div>

				</c:forEach>

			</c:otherwise>

		</c:choose>

	</div>

</body>
</html>