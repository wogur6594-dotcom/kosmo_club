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

<link rel="stylesheet" href="/css/common.css">
</head>

<body>

	<c:if test="${not empty msg}">
		<script>
			alert("${msg}");
		</script>
	</c:if>

	<div class="schedule-detail-box">

		<h3 class="schedule-title">${dto.scheduleTitle}</h3>

		<div class="schedule-divider"></div>

		<div class="schedule-info-grid">

			<div class="schedule-info-table">

				<div class="schedule-info-row">
					<div class="schedule-info-label">작성자</div>
					<div class="schedule-info-value">${dto.memberName}</div>
				</div>

				<div class="schedule-info-row">
					<div class="schedule-info-label">장소</div>
					<div class="schedule-info-value">${dto.scheduleLocation}</div>
				</div>

				<div class="schedule-info-row">
					<div class="schedule-info-label">시작</div>
					<div class="schedule-info-value">
						${fn:replace(fn:substring(dto.scheduleStart.toString(), 0, 16), 'T', ' ')}
					</div>
				</div>

				<c:if test="${not empty dto.scheduleEnd}">
					<div class="schedule-info-row">
						<div class="schedule-info-label">종료</div>
						<div class="schedule-info-value">
							${fn:replace(fn:substring(dto.scheduleEnd.toString(), 0, 16), 'T', ' ')}
						</div>
					</div>
				</c:if>

				<div class="schedule-info-row">
					<div class="schedule-info-label">모집 인원</div>
					<div class="schedule-info-value">${dto.scheduleMax}명</div>
				</div>

				<div class="schedule-info-row">
					<div class="schedule-info-label">현재 참가</div>
					<div class="schedule-info-value">${joinCount}/
						${dto.scheduleMax}명</div>
				</div>

			</div>

			<div class="schedule-divider"></div>

			<h5 class="section-title mb-3">참가자 목록</h5>

			<c:choose>
				<c:when test="${not empty memberList}">
					<div class="schedule-member-list">

						<c:forEach items="${memberList}" var="member">

							<div class="schedule-member-badge">${member.memberName}</div>

						</c:forEach>

					</div>
				</c:when>

				<c:otherwise>
					<p class="text-muted">아직 참가자가 없습니다.</p>
				</c:otherwise>
			</c:choose>

			<div class="schedule-divider"></div>

			<h5 class="section-title mb-3">일정 내용</h5>

			<div class="schedule-content-box">${dto.scheduleContents}</div>

			<div class="schedule-action-area">

				<div class="schedule-left-actions">

					<sec:authorize access="isAuthenticated()">

						<c:choose>
							<c:when test="${isJoin > 0}">
								<form action="../clubScheduleMember/cancel" method="post"
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
										<form action="../clubScheduleMember/join" method="post">

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
							class="btn btn-brown"> 수정 </a>

						<form action="./delete" method="post"
							onsubmit="return confirm('정말 삭제하시겠습니까?');">

							<input type="hidden" name="scheduleNum"
								value="${dto.scheduleNum}">

							<button type="submit" class="btn btn-delete">삭제</button>
						</form>
					</c:if>

				</div>

				<a href="../club/detail?clubNum=${dto.clubNum}" class="btn btn-gray">
					동호회로 돌아가기 </a>

			</div>

		</div>
</body>
</html>