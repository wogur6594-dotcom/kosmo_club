<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/job.css">
<title>내 지원내역</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">


</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="my-box">

		<div class="manage-head">
			<div>
				<h1 class="page-title">내 지원내역</h1>
				<p class="manage-desc">내가 지원한 공고와 지원 상태를 확인할 수 있습니다.</p>
			</div>

			<div class="manage-head-btns">
				<a href="${pageContext.request.contextPath}/job/list"
					class="btn-back-link"> 뒤로가기 </a> <a
					href="${pageContext.request.contextPath}/jobBookmark/myList"
					class="btn-bookmark-link"> 관심 공고 </a>
			</div>
		</div>

		<c:choose>
			<c:when test="${empty list}">
				<div class="empty-box">아직 지원한 공고가 없습니다.</div>
			</c:when>

			<c:otherwise>
				<c:forEach items="${list}" var="dto">

					<div class="apply-card">

						<div class="apply-card-main">

							<div>
								<a
									href="${pageContext.request.contextPath}/job/detail?jobNum=${dto.jobNum}"
									class="job-title"> ${dto.jobTitle} </a>

								<div class="meta">${dto.jobLocation} · ${dto.jobWorkDay} ·
									${dto.jobWorkTime}</div>

								<div class="pay">${dto.jobPay}</div>

								<div class="meta">지원일 ${dto.applyDateFormat}</div>
							</div>

							<div class="apply-action-area">

								<c:choose>
									<c:when test="${dto.applyStatus eq 'WAIT'}">
										<span class="badge-wait">대기중</span>
									</c:when>

									<c:when test="${dto.applyStatus eq 'ACCEPT'}">
										<span class="badge-accept">승인</span>
									</c:when>

									<c:otherwise>
										<span class="badge-reject">거절</span>
									</c:otherwise>
								</c:choose>

								<c:if test="${dto.applyStatus eq 'WAIT'}">
									<form
										action="${pageContext.request.contextPath}/jobApply/cancel"
										method="post" onsubmit="return confirm('지원 취소하시겠습니까?');">

										<input type="hidden" name="jobNum" value="${dto.jobNum}">

										<button type="submit" class="btn-apply-cancel">지원 취소
										</button>
									</form>
								</c:if>

							</div>

						</div>

					</div>

				</c:forEach>
			</c:otherwise>
		</c:choose>

	</div>

</body>
</html>