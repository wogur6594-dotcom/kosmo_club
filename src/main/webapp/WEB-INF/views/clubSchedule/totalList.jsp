<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 동호회 일정</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/club.css">
</head>

<body class="total-schedule-page">

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="schedule-list-box">

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h3 class="page-title mb-0">전체 동호회 일정</h3>

			<a href="/club/list" class="btn btn-gray"> 동호회 목록 </a>
		</div>

		<c:choose>
			<c:when test="${empty scheduleList}">
				<div class="empty-box">등록된 일정이 없습니다.</div>
			</c:when>

			<c:otherwise>
				<c:forEach items="${scheduleList}" var="dto">

					<a href="/clubSchedule/detail?scheduleNum=${dto.scheduleNum}"
						class="schedule-card-link">

						<div class="schedule-card">

							<div class="club-name-badge">${dto.clubName}</div>

							<div class="schedule-title">${dto.scheduleTitle}</div>

							<div class="schedule-info">
								<strong>장소</strong> :
								<c:choose>
									<c:when test="${empty dto.scheduleLocation}">
									미정
								</c:when>
									<c:otherwise>
									${dto.scheduleLocation}
								</c:otherwise>
								</c:choose>
							</div>

							<div class="schedule-date-line">

								<div class="schedule-info">
									<strong>시작</strong> :
									${fn:replace(fn:substring(dto.scheduleStart.toString(), 0, 16), 'T', ' ')}
								</div>

								<c:if test="${not empty dto.scheduleEnd}">
									<div class="schedule-info">
										<strong>종료</strong> :
										${fn:replace(fn:substring(dto.scheduleEnd.toString(), 0, 16), 'T', ' ')}
									</div>
								</c:if>

							</div>

							<div class="schedule-info">
								<strong>모집 인원</strong> : ${dto.scheduleMax}명
							</div>

						</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>

	</div>

	<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>

</body>
</html>