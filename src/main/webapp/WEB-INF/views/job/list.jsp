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

<link rel="stylesheet" href="/css/job.css">
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="job-container">

		<div class="job-top-bar">

			<form action="./list" method="get" class="search-box">

				<div class="search-group">

					<select name="kind">
						<option value="all">알바 전체</option>
						<option value="title">제목</option>
						<option value="contents">내용</option>
						<option value="location">지역</option>
					</select> <input type="text" name="search" value="${pager.search}"
						placeholder="검색어를 입력해주세요">

					<button type="submit">→</button>

				</div>

			</form>

			<sec:authorize access="isAuthenticated()">
				<div class="job-user-menu">

					<a href="${pageContext.request.contextPath}/job/myJobList"
						class="btn btn-sm btn-job-main"> 내 공고 관리 </a> <a
						href="${pageContext.request.contextPath}/jobApply/myList"
						class="btn btn-sm btn-job-sub"> 내 지원내역 </a>

				</div>
			</sec:authorize>

		</div>



		<div class="job-layout">

			<aside class="filter-box">

				<div class="filter-head">
					<div class="filter-title">필터</div>
					<a href="./list" class="filter-reset">초기화</a>
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

					<button type="submit" class="job-filter-btn">필터 적용</button>
				</form>

			</aside>

			<main class="job-list">

				<c:choose>
					<c:when test="${empty list}">
						<div class="empty-box">등록된 알바 공고가 없습니다.</div>
					</c:when>

					<c:otherwise>
						<c:forEach items="${list}" var="dto">

							<div
								class="job-item ${dto.currentApplyMember ge dto.jobMaxMember ? 'opacity-50' : ''}">

								<div class="job-item-content">

									<a href="./detail?jobNum=${dto.jobNum}" class="job-title">
										${dto.jobTitle} </a>

									<div class="job-meta">${dto.memberName}·
										${dto.jobLocation} · ${dto.createDateFormat}</div>

									<div class="job-time">· ${dto.jobType} ·
										${dto.jobWorkDay} · ${dto.jobWorkTime}</div>

									<div class="job-badge-area">

										<span class="badge-soft">${dto.jobCategory}</span>

										<c:choose>
											<c:when test="${dto.currentApplyMember ge dto.jobMaxMember}">
												<span class="badge-closed">모집완료</span>
											</c:when>

											<c:otherwise>
												<span class="badge-open">모집중</span>
											</c:otherwise>
										</c:choose>

										<span class="job-apply-count"> 지원자
											${dto.currentApplyMember} / ${dto.jobMaxMember} </span>

									</div>

								</div>

								<c:if test="${not empty dto.fileName}">
									<img src="/files/job/${dto.fileName}" class="job-thumb">
								</c:if>

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
		<a href="/job/create" class="floating-write-btn">+ 공고 쓰기</a>
	</sec:authorize>

</body>
</html>