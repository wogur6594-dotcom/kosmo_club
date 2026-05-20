<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네알바</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #ffffff;
	color: #212529;
}

.job-container {
	max-width: 1200px;
	margin: 40px auto;
}

.search-box {
	border: 1px solid #e5e5e5;
	border-radius: 28px;
	padding: 10px 18px;
	display: flex;
	align-items: center;
	margin-bottom: 35px;
}

.search-box select {
	border: none;
	outline: none;
	font-weight: 600;
	margin-right: 12px;
}

.search-box input {
	border: none;
	outline: none;
	flex: 1;
}

.search-box button {
	border: none;
	background-color: #343a40;
	color: white;
	width: 38px;
	height: 38px;
	border-radius: 50%;
	font-weight: 700;
}

.page-title {
	font-size: 28px;
	font-weight: 800;
	margin-bottom: 35px;
}

.filter-box {
	width: 230px;
	padding-right: 25px;
}

.filter-title {
	font-weight: 800;
	margin-bottom: 20px;
}

.filter-section {
	border-bottom: 1px solid #eee;
	padding-bottom: 20px;
	margin-bottom: 22px;
}

.filter-section h6 {
	font-weight: 800;
	margin-bottom: 15px;
}

.filter-section label {
	display: block;
	margin-bottom: 10px;
	color: #343a40;
}

.job-list {
	flex: 1;
}

.job-item {
	position: relative;
	padding: 24px 0;
	border-bottom: 1px solid #eee;
}

.job-title {
	font-size: 21px;
	font-weight: 800;
	color: #111;
	margin-bottom: 8px;
}

.job-title:hover {
	color: #ff6f0f;
	text-decoration: none;
}

.job-meta {
	color: #868e96;
	font-size: 14px;
	margin-bottom: 8px;
}

.job-pay {
	font-weight: 800;
	color: #212529;
}

.job-time {
	color: #6c757d;
}

.badge-soft {
	background-color: #fff3e8;
	color: #ff6f0f;
	font-size: 12px;
	padding: 5px 8px;
	border-radius: 4px;
}

.floating-write-btn {
	position: fixed;
	right: 70px;
	bottom: 60px;
	background-color: #ff6f0f;
	color: white;
	padding: 14px 24px;
	border-radius: 12px;
	font-weight: 800;
	z-index: 999;
	box-shadow: 0 6px 18px rgba(0, 0, 0, 0.18);
}

.floating-write-btn:hover {
	color: white;
	text-decoration: none;
	background-color: #e85f00;
}

.pagination .page-link {
	color: #ff6f0f;
}

.pagination .active .page-link {
	background-color: #ff6f0f;
	border-color: #ff6f0f;
	color: white;
}

.opacity-50 {
	opacity: 0.68;
}

.btn-job-main {
	background-color: #ff6f0f;
	color: white;
	border-radius: 10px;
	font-weight: 700;
}

.btn-job-main:hover {
	background-color: #e85f00;
	color: white;
}

.btn-job-sub {
	background-color: #fff3e8;
	color: #ff6f0f;
	border-radius: 10px;
	font-weight: 700;
}

.btn-job-sub:hover {
	background-color: #ffe1c2;
	color: #e85f00;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="job-container">

		<form action="./list" method="get" class="search-box">
			<select name="kind">
				<option value="all">알바 전체</option>
				<option value="title">제목</option>
				<option value="contents">내용</option>
				<option value="location">지역</option>
			</select> <input type="text" name="search" value="${pager.search}"
				placeholder="검색어를 입력해주세요">

			<button type="submit">→</button>
		</form>

		<h1 class="page-title">동네알바</h1>

		<sec:authorize access="isAuthenticated()">
			<div class="mb-4 text-right">

				<a href="${pageContext.request.contextPath}/job/myJobList"
					class="btn btn-sm btn-job-main"> 내 공고 관리 </a> <a
					href="${pageContext.request.contextPath}/jobApply/myList"
					class="btn btn-sm btn-job-sub"> 내 지원내역 </a>

			</div>
		</sec:authorize>

		<div class="d-flex">

			<aside class="filter-box">
				<div class="d-flex justify-content-between">
					<div class="filter-title">필터</div>
					<a href="./list" class="text-muted small">초기화</a>
				</div>

				<div class="filter-section">
					<h6>근무 유형</h6>

					<c:forEach items="${typeList}" var="type">
						<label> <input type="checkbox" name="jobType"
							form="filterForm" value="${type}"
							${pager.checkedType(type) ? 'checked' : ''}> ${type}
						</label>
					</c:forEach>
				</div>

				<form id="filterForm" action="./list" method="get">
					<input type="hidden" name="search" value="${pager.search}">
					<input type="hidden" name="kind" value="${pager.kind}">

					<div class="filter-section">
						<h6>하는 일</h6>

						<c:forEach items="${categoryList}" var="category">
							<label> <input type="checkbox" name="jobCategory"
								value="${category}"
								${pager.checkedCategory(category) ? 'checked' : ''}>
								${category}
							</label>
						</c:forEach>
					</div>

					<button type="submit" class="btn btn-sm btn-dark btn-block">
						필터 적용</button>
				</form>
			</aside>

			<main class="job-list">

				<c:choose>
					<c:when test="${empty list}">
						<div class="text-center text-muted mt-5">등록된 알바 공고가 없습니다.</div>
					</c:when>

					<c:otherwise>
						<c:forEach items="${list}" var="dto">
							<div
								class="job-item
	${dto.currentApplyMember ge dto.jobMaxMember ? 'opacity-50' : ''}">

								<a href="./detail?jobNum=${dto.jobNum}" class="job-title">
									${dto.jobTitle} </a>

								<!-- 썸네일 이미지 -->
								<c:if test="${not empty dto.fileName}">
									<img src="/files/job/${dto.fileName}"
										style="width: 120px; height: 120px; object-fit: cover; border-radius: 12px; float: right;">
								</c:if>

								<div class="job-meta">${dto.memberName}·
									${dto.jobLocation} · ${dto.createDateFormat}</div>

								<div>
									<span class="job-time"> · ${dto.jobType} ·
										${dto.jobWorkDay} · ${dto.jobWorkTime} </span>
								</div>

								<div class="mt-2 d-flex align-items-center flex-wrap">

									<span class="badge-soft mr-2"> ${dto.jobCategory} </span>

									<c:choose>

										<c:when test="${dto.currentApplyMember ge dto.jobMaxMember}">

											<span class="badge badge-danger mr-2"> 모집완료 </span>

										</c:when>

										<c:otherwise>

											<span class="badge badge-success mr-2"> 모집중 </span>

										</c:otherwise>

									</c:choose>

									<span class="text-muted small"> 지원자
										${dto.currentApplyMember} / ${dto.jobMaxMember} </span>

								</div>

							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>

				<c:if test="${not empty list}">
					<nav class="mt-4">
						<ul class="pagination justify-content-center">

							<c:if test="${pager.pre}">
								<li class="page-item"><a class="page-link"
									href="./list?page=${pager.start - 1}&search=${pager.search}">
										이전 </a></li>
							</c:if>

							<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
								<li class="page-item ${pager.page eq i ? 'active' : ''}"><a
									class="page-link"
									href="./list?page=${i}&search=${pager.search}"> ${i} </a></li>
							</c:forEach>

							<c:if test="${pager.next}">
								<li class="page-item"><a class="page-link"
									href="./list?page=${pager.end + 1}&search=${pager.search}">
										다음 </a></li>
							</c:if>

						</ul>
					</nav>
				</c:if>

			</main>
		</div>
	</div>

	<sec:authorize access="isAuthenticated()">
		<a href="/job/create" class="floating-write-btn"> + 공고 쓰기 </a>
	</sec:authorize>

</body>
</html>