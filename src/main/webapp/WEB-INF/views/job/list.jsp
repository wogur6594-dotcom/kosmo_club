<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
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
	background-color: #fff7f3;
	color: #2f241d;
}

.job-container {
	max-width: 1280px;
	margin: 50px auto;
	padding: 35px;
	background-color: white;
	border-radius: 24px;
	box-shadow: 0 8px 24px rgba(120, 80, 40, 0.08);
	border: 1px solid #f1dfd0;
}

.search-box {
	border: 1px solid #ead8c8;
	border-radius: 18px;
	padding: 10px 14px;
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 32px;
	background-color: #fffaf7;
}

.search-box select {
	width: 120px;
	height: 42px;
	border: none;
	background: transparent;
	outline: none;
	font-weight: 800;
	color: #3f2d20;
	flex-shrink: 0;
}

.search-box input {
	height: 42px;
	border: none;
	background: transparent;
	outline: none;
	flex: 1;
	min-width: 0;
	color: #3f2d20;
	font-weight: 700;
}

.search-box button {
	border: none;
	background-color: #a35400;
	color: white;
	width: 46px;
	height: 42px;
	border-radius: 12px;
	font-weight: 900;
	flex-shrink: 0;
}

.search-box button:hover {
	background-color: #8b4700;
}

.page-title {
	font-size: 34px;
	font-weight: 900;
	color: #2d2118;
	margin-bottom: 30px;
}

.filter-box {
	width: 250px;
	padding: 24px;
	background-color: #fffaf7;
	border-radius: 20px;
	border: 1px solid #ead8c8;
	height: fit-content;
	margin-right: 26px;
}

.filter-title, .filter-section h6 {
	font-weight: 900;
	color: #3f2d20;
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
	padding: 26px;
	border-radius: 20px;
	background-color: #fffaf7;
	border: 1px solid #f1dfd0;
	margin-bottom: 18px;
	transition: 0.2s;
}

.job-item:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 20px rgba(120, 80, 40, 0.08);
}

.job-title {
	font-size: 22px;
	font-weight: 900;
	color: #2d2118;
	margin-bottom: 10px;
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
	right: 50px;
	bottom: 45px;
	background-color: #a35400;
	color: white;
	padding: 15px 24px;
	border-radius: 18px;
	font-weight: 900;
	z-index: 999;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.16);
	transition: 0.2s;
}

.floating-write-btn:hover {
	color: white;
	text-decoration: none;
	background-color: #8b4700;
	transform: translateY(-2px);
}

.pagination .page-link {
	color: #8b5e34;
	border-color: #ead8c8;
	border-radius: 10px;
	margin: 0 3px;
	font-weight: 700;
}

.pagination .page-link:hover {
	background-color: #fff3e6;
	color: #704722;
}

.pagination .active .page-link {
	background-color: #a35400;
	border-color: #a35400;
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

.badge-success {
	background-color: #d3f9d8;
	color: #2b8a3e;
	border-radius: 999px;
	padding: 6px 12px;
	font-weight: 800;
	border: none;
}

.badge-danger {
	background-color: #ffe3e3;
	color: #c92a2a;
	border-radius: 999px;
	padding: 6px 12px;
	font-weight: 800;
	border: none;
}

.job-top-actions {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: -10px;
	margin-bottom: 26px;
}

.job-action-main, .job-action-sub {
	height: 40px;
	padding: 0 18px;
	border-radius: 999px;
	font-size: 14px;
	font-weight: 800;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	text-decoration: none;
}

.job-action-main {
	background-color: #a35400;
	color: white;
}

.job-action-main:hover {
	background-color: #8b4700;
	color: white;
	text-decoration: none;
}

.job-action-sub {
	background-color: #fff3e6;
	color: #a35400;
	border: 1px solid #ead1bb;
}

.job-action-sub:hover {
	background-color: #ffe5cc;
	color: #8b4700;
	text-decoration: none;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="job-container">
		<sec:authorize access="isAuthenticated()">
			<div class="job-top-actions">

				<a href="${pageContext.request.contextPath}/job/myJobList"
					class="job-action-main"> 내 공고 관리 </a> <a
					href="${pageContext.request.contextPath}/jobApply/myList"
					class="job-action-sub"> 내 지원내역 </a>

			</div>
		</sec:authorize>

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
${dto.currentApplyMember ge dto.jobMaxMember ? 'opacity-50' : ''}"
								onclick="location.href='./detail?jobNum=${dto.jobNum}'">

								<a href="./detail?jobNum=${dto.jobNum}" class="job-title">
									${dto.jobTitle} </a>

								<!-- 썸네일 이미지 -->
								<c:if test="${not empty dto.fileName}">
									<c:choose>
										<c:when test="${not empty dto.fileName and fn:startsWith(dto.fileName, 'http')}">
											<img src="${dto.fileName}" style="width: 120px; height: 120px; object-fit: cover; border-radius: 12px; float: right;">
										</c:when>
										<c:otherwise>
											<img src="/files/job/${dto.fileName}" style="width: 120px; height: 120px; object-fit: cover; border-radius: 12px; float: right;">
										</c:otherwise>
									</c:choose>
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