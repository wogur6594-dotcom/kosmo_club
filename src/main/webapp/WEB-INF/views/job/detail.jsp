<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알바 공고 상세</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/common.css">

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="detail-box">

		<span class="category-badge">${dto.jobCategory}</span>

		<h1 class="detail-title">${dto.jobTitle}</h1>

		<!-- 썸네일 -->

		<c:if test="${not empty dto.fileName}">
			<div class="mb-4">
				<c:choose>
					<c:when test="${not empty dto.fileName and fn:startsWith(dto.fileName, 'http')}">
						<img src="${dto.fileName}" class="job-image">
					</c:when>
					<c:otherwise>
						<img src="/files/job/${dto.fileName}" class="job-image">
					</c:otherwise>
				</c:choose>
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

		<div class="job-action-area">

			<sec:authorize access="isAuthenticated()">

				<sec:authentication property="principal.memberNum"
					var="loginMemberNum" />

				<c:if test="${dto.memberNum eq loginMemberNum}">
					<a href="./update?jobNum=${dto.jobNum}" class="btn btn-brown">
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

				<hr class="action-divider">

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

			<a href="./list" class="btn btn-outline-secondary">목록</a>

		</div>

	</div>

</body>
</html>