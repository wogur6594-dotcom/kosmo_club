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

<link rel="stylesheet" href="/css/job.css">
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="manage-box">

		<div class="manage-head">
			<div>
				<h1 class="page-title">내 공고 관리</h1>
				<p class="manage-desc">내가 등록한 동네알바 공고와 지원 현황을 확인할 수 있습니다.</p>
			</div>

			<div class="manage-head-btns">
				<a href="${pageContext.request.contextPath}/job/list"
					class="btn-back-link"> 뒤로가기 </a>
			</div>
		</div>

		<c:choose>
			<c:when test="${empty list}">
				<div class="empty-box">등록한 공고가 없습니다.</div>
			</c:when>

			<c:otherwise>
				<c:forEach items="${list}" var="dto">

					<div
						class="manage-job-card ${dto.currentApplyMember ge dto.jobMaxMember ? 'closed-job-card' : ''}">

						<div class="manage-job-main">

							<a
								href="${pageContext.request.contextPath}/job/detail?jobNum=${dto.jobNum}"
								class="job-title"> ${dto.jobTitle} </a>

							<div class="meta">${dto.jobLocation}·${dto.jobWorkDay} ·
								${dto.jobWorkTime}</div>

							<div class="pay">${dto.jobPay}</div>

							<div class="meta">지원자 ${dto.currentApplyMember} /
								${dto.jobMaxMember}</div>

						</div>

						<div class="manage-job-applicant">

							<c:choose>
								<c:when test="${dto.applyCount gt 0}">
									<div class="recent-applicant">
										최근 지원자 : ${dto.recentApplicantName}

										<c:if test="${dto.applyCount gt 1}">
											외 ${dto.applyCount - 1}명
										</c:if>
									</div>
								</c:when>

								<c:otherwise>
									<div class="recent-applicant empty">아직 지원자가 없습니다.</div>
								</c:otherwise>
							</c:choose>

						</div>

						<div class="manage-job-actions">

							<c:choose>
								<c:when test="${dto.currentApplyMember ge dto.jobMaxMember}">
									<span class="badge-closed">모집완료</span>
								</c:when>

								<c:otherwise>
									<span class="badge-open">모집중</span>
								</c:otherwise>
							</c:choose>

							<div class="manage-btn-area">
								<a
									href="${pageContext.request.contextPath}/jobApply/applicantList?jobNum=${dto.jobNum}"
									class="btn-manage-primary"> 지원자 보기 </a> <a
									href="${pageContext.request.contextPath}/job/update?jobNum=${dto.jobNum}"
									class="btn-manage-sub"> 수정 </a>

								<form action="${pageContext.request.contextPath}/job/delete"
									method="post" onsubmit="return confirm('정말 이 공고를 삭제하시겠습니까?');">
									<input type="hidden" name="jobNum" value="${dto.jobNum}">
									<button type="submit" class="btn-manage-delete">삭제</button>
								</form>
							</div>

						</div>

					</div>

				</c:forEach>
			</c:otherwise>
		</c:choose>

	</div>

</body>
</html>