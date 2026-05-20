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

.apply-status-box {
	margin-top: 18px;
	padding: 16px 18px;
	border-radius: 14px;
	font-weight: 700;
}

.apply-wait {
	background-color: #fff3e8;
	color: #d9480f;
	border: 1px solid #ffd8a8;
}

.apply-accept {
	background-color: #e6fcf5;
	color: #087f5b;
	border: 1px solid #96f2d7;
}

.apply-reject {
	background-color: #fff5f5;
	color: #c92a2a;
	border: 1px solid #ffc9c9;
}

.apply-closed {
	background-color: #f1f3f5;
	color: #495057;
	border: 1px solid #dee2e6;
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

			<div class="info-row">
				<div class="info-label">모집현황</div>

				<div class="info-value">

					<c:choose>

						<c:when test="${dto.currentApplyMember ge dto.jobMaxMember}">

							<span class="badge badge-danger"> 모집완료 </span>

				(${dto.currentApplyMember} / ${dto.jobMaxMember})

			</c:when>

						<c:otherwise>

							<span class="badge badge-success"> 모집중 </span>

				(${dto.currentApplyMember} / ${dto.jobMaxMember})

			</c:otherwise>

					</c:choose>

				</div>
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

				<hr>

				<c:if test="${dto.memberNum ne loginMemberNum}">

					<c:choose>

						<c:when test="${bookmarkCheck == 0}">

							<form action="${pageContext.request.contextPath}/jobBookmark/add"
								method="post" style="display: inline;">

								<input type="hidden" name="jobNum" value="${dto.jobNum}">

								<button type="submit" class="btn btn-outline-warning mr-2">
									관심 공고 추가</button>

							</form>

						</c:when>

						<c:otherwise>

							<form
								action="${pageContext.request.contextPath}/jobBookmark/delete"
								method="post" style="display: inline;">

								<input type="hidden" name="jobNum" value="${dto.jobNum}">

								<button type="submit" class="btn btn-warning mr-2">관심
									공고 취소</button>

							</form>

						</c:otherwise>

					</c:choose>

				</c:if>

				<c:choose>

					<c:when test="${isWriter}">
						<a
							href="${pageContext.request.contextPath}/jobApply/applicantList?jobNum=${dto.jobNum}"
							class="btn btn-dark"> 지원자 보기 </a>
					</c:when>

					<c:when test="${isApply and applyStatus eq 'WAIT'}">
						<form action="${pageContext.request.contextPath}/jobApply/cancel"
							method="post" style="display: inline;"
							onsubmit="return confirm('지원 취소하시겠습니까?');">

							<input type="hidden" name="jobNum" value="${dto.jobNum}">

							<button type="submit" class="btn btn-secondary">지원 취소</button>
						</form>
					</c:when>

					<c:otherwise>
						<form action="${pageContext.request.contextPath}/jobApply/apply"
							method="post" style="display: inline;"
							onsubmit="return confirm('이 공고에 지원하시겠습니까?');">

							<input type="hidden" name="jobNum" value="${dto.jobNum}">


							<c:if test="${isApply}">

								<c:choose>

									<c:when test="${applyStatus eq 'WAIT'}">
										<div class="apply-status-box apply-wait">지원 완료 · 현재 승인
											대기중입니다.</div>
									</c:when>

									<c:when test="${applyStatus eq 'ACCEPT'}">
										<div class="apply-status-box apply-accept">승인 완료 · 채용이
											승인되었습니다.</div>
									</c:when>

									<c:when test="${applyStatus eq 'REJECT'}">
										<div class="apply-status-box apply-reject">거절됨 · 해당 공고
											지원이 거절되었습니다.</div>
									</c:when>

								</c:choose>

							</c:if>

							<c:choose>

								<c:when test="${dto.currentApplyMember ge dto.jobMaxMember}">

									<button type="button" class="btn btn-danger" disabled>

										모집완료</button>

								</c:when>

								<c:otherwise>

									<button type="submit" class="btn btn-warning">지원하기</button>

								</c:otherwise>

							</c:choose>
						</form>
					</c:otherwise>

				</c:choose>

			</sec:authorize>

			<a href="./list" class="btn btn-soft">목록</a>

		</div>

	</div>

</body>
</html>