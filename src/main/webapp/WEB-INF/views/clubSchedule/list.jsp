<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동호회 일정</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.schedule-list-box {
	max-width: 950px;
	margin: 50px auto;
	background-color: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.page-title {
	font-weight: 800;
	color: #3f2d20;
	margin-bottom: 25px;
}

.schedule-card {
	border: 1px solid #ead8c7;
	border-radius: 16px;
	padding: 22px;
	margin-bottom: 18px;
	background-color: #fffdfb;
}

.schedule-title {
	font-size: 21px;
	font-weight: 800;
	color: #3f2d20;
	text-decoration: none;
}

.schedule-title:hover {
	color: #a35400;
	text-decoration: none;
}

.schedule-info {
	margin-top: 12px;
	color: #6d5b4d;
	font-size: 15px;
}

.btn-brown {
	background-color: #a35400;
	color: white;
	border-radius: 12px;
	font-weight: 700;
	padding: 8px 18px;
}

.btn-brown:hover {
	background-color: #8a4600;
	color: white;
}

.btn-gray {
	background-color: #8c7b6d;
	color: white;
	border-radius: 12px;
	font-weight: 700;
	padding: 8px 18px;
}

.btn-gray:hover {
	background-color: #77685d;
	color: white;
}

.empty-box {
	text-align: center;
	padding: 60px 20px;
	color: #999;
	font-size: 17px;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="schedule-list-box">

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h3 class="page-title mb-0">동호회 일정</h3>

			<div>
				<a href="../club/detail?clubNum=${clubNum}" class="btn btn-gray">
					동호회로 돌아가기 </a> <a href="./create?clubNum=${clubNum}"
					class="btn btn-brown"> 일정 등록 </a>
			</div>
		</div>

		<c:choose>
			<c:when test="${empty scheduleList}">
				<div class="empty-box">등록된 일정이 없습니다.</div>
			</c:when>

			<c:otherwise>
				<c:forEach items="${scheduleList}" var="dto">

					<div class="schedule-card">

						<a href="./detail?scheduleNum=${dto.scheduleNum}"
							class="schedule-title"> ${dto.scheduleTitle} </a>

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

						<div class="schedule-info">
							<strong>모집 인원</strong> : ${dto.scheduleMax}명
						</div>

					</div>

				</c:forEach>
			</c:otherwise>
		</c:choose>

	</div>

</body>
</html>