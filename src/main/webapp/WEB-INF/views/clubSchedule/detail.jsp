<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 상세</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.schedule-detail-box {
	max-width: 760px;
	margin: 60px auto;
	background-color: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
}

.section-title {
	font-weight: 700;
	color: #3f2d20;
}

.info-label {
	font-weight: 700;
	color: #5f4b3b;
}

.btn-brown {
	background-color: #b36200;
	color: white;
	border-radius: 12px;
	padding: 6px 16px;
	border: none;
}

.btn-brown:hover {
	color: white;
	background-color: #9d5600;
}

.btn-gray {
	background-color: #8c7b6d;
	color: white;
	border-radius: 12px;
	padding: 6px 16px;
}

.btn-gray:hover {
	color: white;
	background-color: #77685d;
}

.content-box {
	background-color: #fff3e6;
	border-radius: 14px;
	padding: 18px;
	min-height: 120px;
	color: #4a382b;
	line-height: 1.7;
}

.btn-delete {
	background-color: #d9534f;
	color: white;
	border-radius: 12px;
	padding: 6px 16px;
	border: none;
}

.btn-delete:hover {
	background-color: #c9302c;
	color: white;
}
</style>
</head>

<body>

	<c:if test="${not empty msg}">
		<script>
			alert("${msg}");
		</script>
	</c:if>

	<div class="schedule-detail-box">

		<h3 class="section-title mb-4">${dto.scheduleTitle}</h3>

		<hr>

		<p>
			<span class="info-label">작성자</span> · ${dto.memberName}
		</p>

		<p>
			<span class="info-label">장소</span> · ${dto.scheduleLocation}
		</p>

		<p>
			<span class="info-label">시작</span> ·
			${fn:replace(fn:substring(dto.scheduleStart.toString(), 0, 16), 'T', ' ')}
		</p>

		<c:if test="${not empty dto.scheduleEnd}">
			<p>
				<span class="info-label">종료</span> ·
				${fn:replace(fn:substring(dto.scheduleEnd.toString(), 0, 16), 'T', ' ')}
			</p>
		</c:if>

		<p>
			<span class="info-label">모집 인원</span> · ${dto.scheduleMax}명
		</p>

		<p>
			<span class="info-label">현재 참가</span> · ${joinCount} /
			${dto.scheduleMax}명
		</p>

		<hr>

		<h5 class="section-title mb-3">참가자 목록</h5>

		<c:choose>
			<c:when test="${not empty memberList}">
				<ul class="list-group mb-3">
					<c:forEach items="${memberList}" var="member">
						<li class="list-group-item"
							style="border-radius: 10px; margin-bottom: 8px;">
							${member.memberName}</li>
					</c:forEach>
				</ul>
			</c:when>

			<c:otherwise>
				<p class="text-muted">아직 참가자가 없습니다.</p>
			</c:otherwise>
		</c:choose>

		<hr>

		<div class="content-box">${dto.scheduleContents}</div>

		<div class="d-flex justify-content-between align-items-center mt-4">

			<div>

				<sec:authorize access="isAuthenticated()">

					<c:choose>

						<c:when test="${isJoin > 0}">
							<form action="../clubScheduleMember/cancel" method="post"
								style="display: inline;"
								onsubmit="return confirm('일정 참가를 취소하시겠습니까?');">

								<input type="hidden" name="scheduleNum"
									value="${dto.scheduleNum}">

								<button type="submit" class="btn btn-gray">참가 취소</button>
							</form>
						</c:when>

						<c:otherwise>

							<c:choose>

								<c:when test="${joinCount >= dto.scheduleMax}">
									<button type="button" class="btn btn-secondary" disabled>
										정원 초과</button>
								</c:when>

								<c:otherwise>
									<form action="../clubScheduleMember/join" method="post"
										style="display: inline;">

										<input type="hidden" name="scheduleNum"
											value="${dto.scheduleNum}"> <input type="hidden"
											name="clubNum" value="${dto.clubNum}">

										<button type="submit" class="btn btn-brown">참가하기</button>
									</form>
								</c:otherwise>

							</c:choose>

						</c:otherwise>

					</c:choose>

				</sec:authorize>

				<c:if test="${canEdit}">
					<a href="./update?scheduleNum=${dto.scheduleNum}"
						class="btn btn-sm btn-brown ml-2"> 수정 </a>

					<form action="./delete" method="post" style="display: inline;">

						<input type="hidden" name="scheduleNum" value="${dto.scheduleNum}">

						<button type="submit" class="btn btn-sm btn-delete ml-2"
							onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>

					</form>
				</c:if>

			</div>

			<a href="../club/detail?clubNum=${dto.clubNum}" class="btn btn-gray">
				동호회로 돌아가기 </a>

		</div>

	</div>

</body>
</html>