<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.club-wrapper {
	max-width: 1500px;
}

.side-card, .main-card {
	background-color: white;
	border: none;
	border-radius: 18px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
}

.section-title {
	font-weight: 700;
	color: #3f2d20;
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

.club-image {
	width: 100%;
	height: 200px;
	object-fit: cover;
	border-radius: 16px;
}

.info-label {
	font-weight: 700;
	color: #5f4b3b;
}

.notice-box {
	background-color: #fff3e6;
	border-radius: 14px;
	padding: 12px;
	color: #5f4b3b;
	font-size: 14px;
}

.notice-item {
	display: block;
	background-color: #fff1df;
	color: #8a4b00;
	font-weight: 600;
	padding: 14px 16px;
	border-radius: 12px;
	margin-bottom: 10px;
	text-decoration: none;
}

.notice-item:hover {
	background-color: #ffe4c2;
	color: #6f3c00;
	text-decoration: none;
}

.schedule-item {
	padding: 8px 0;
}

.schedule-item:last-child {
	border-bottom: none;
}

.schedule-date {
	font-size: 13px;
	font-weight: 700;
	color: #b36200;
}

.schedule-title {
	margin-bottom: 4px;
	font-size: 15px;
	font-weight: 700;
	color: #3f2d20;
}

.table thead th {
	border-top: none;
	color: #5f4b3b;
}

.table td {
	vertical-align: middle;
	font-size: 15px;
}

.board-title-link {
	color: #a85b00;
	text-decoration: none;
}

.board-title-link:hover {
	color: #7d4300;
	text-decoration: none;
}

@media ( max-width : 991px) {
	.center-board {
		order: 1;
	}
	.left-side {
		order: 2;
	}
	.right-side {
		order: 3;
	}
}
</style>

</head>

<body>

	<c:if test="${not empty msg}">
		<script>
			alert("${msg}");
		</script>
	</c:if>

	<c:if test="${not empty message}">
		<script>
			alert("${message}");
		</script>
	</c:if>

	<c:if test="${param.message eq 'memberOnly'}">
		<script>
			alert("동호회 멤버만 글 작성이 가능합니다.");
		</script>
	</c:if>

	<c:if test="${param.message eq 'scheduleMemberOnly'}">
		<script>
			alert("동호회 가입 회원만 일정 등록이 가능합니다.");
		</script>
	</c:if>

	<c:if test="${param.message eq 'noticeOwnerOnly'}">
		<script>
			alert("공지 등록은 동호회 회장만 가능합니다.");
		</script>
	</c:if>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container mt-5 club-wrapper">

		<!-- 상단 제목 / 버튼 -->
		<div class="d-flex justify-content-between align-items-center mb-4">

			<div class="text-center flex-grow-1">


				<h1 class="section-title mb-0" style="font-size: 52px;">
					${dto.clubName}</h1>

			</div>

			<div>
				<c:choose>

					<c:when test="${isMember}">
						<button type="button" class="btn btn-sm btn-secondary" disabled>
							가입완료</button>
					</c:when>

					<c:when test="${isWaiting}">
						<button type="button" class="btn btn-sm btn-warning" disabled>
							가입 대기중</button>
					</c:when>

					<c:otherwise>

						<form action="${pageContext.request.contextPath}/clubMember/join"
							method="post" style="display: inline;"
							onsubmit="return confirm('이 동호회에 가입 신청하시겠습니까?');">

							<input type="hidden" name="clubNum" value="${dto.clubNum}">

							<button type="submit" class="btn btn-sm btn-brown">가입하기
							</button>

						</form>

					</c:otherwise>

				</c:choose>
				<!-- 가입승인 -->
				<c:if test="${roleNum eq 1}">
					<a href="/clubMember/waitList?clubNum=${dto.clubNum}"
						class="btn btn-sm"
						style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 16px;">
						가입 신청 목록 </a>
				</c:if>
				<!-- 가입승인 끝 -->

				<!-- 강퇴 -->
				<c:if test="${roleNum eq 1}">
					<a href="/clubMember/memberList?clubNum=${dto.clubNum}"
						class="btn btn-sm"
						style="background-color: #5f4b3b; color: white; border-radius: 12px; padding: 6px 16px;">
						회원 목록 </a>
				</c:if>
				<!-- 강퇴 끝 -->

				<c:if test="${isMember}">
					<!-- <span class="badge badge-secondary ml-2"> 가입완료 </span> -->
				</c:if>

				<c:if test="${isMember and roleNum eq 2}">
					<form action="${pageContext.request.contextPath}/clubMember/leave"
						method="post" style="display: inline;"
						onsubmit="return confirm('정말 이 동호회에서 탈퇴하시겠습니까?');">

						<input type="hidden" name="clubNum" value="${dto.clubNum}">

						<button type="submit" class="btn btn-sm"
							style="background-color: #6c757d; color: white; border-radius: 12px; padding: 6px 16px; border: none;">
							탈퇴하기</button>
					</form>
				</c:if>

				<a href="./list?page=${param.page}" class="btn btn-sm btn-gray">
					목록으로 </a>

				<c:if test="${canDelete}">
					<form action="./delete" method="post" style="display: inline;"
						onsubmit="return confirm('정말 삭제하시겠습니까?');">

						<input type="hidden" name="clubNum" value="${dto.clubNum}">

						<button type="submit" class="btn btn-sm"
							style="background-color: #b00020; color: white; border-radius: 12px; padding: 6px 16px; border: none;">
							삭제</button>
					</form>
				</c:if>
			</div>

		</div>

		<div class="row">

			<!-- 왼쪽 사이드바 -->
			<div class="col-lg-3 mb-4 left-side">
				<div class="side-card p-3 mb-3">

					<c:if test="${not empty dto.fileDTO}">
						<img src="/files/club/${dto.fileDTO.fileName}"
							alt="${dto.clubName}" class="club-image mb-3">
					</c:if>

					<h5 class="section-title mb-3">동호회 정보</h5>

					<p class="mb-3">
						<span class="info-label">회장</span> · ${dto.ownerName}
					</p>
					<p class="mb-2">
						<span class="info-label">지역</span> · ${dto.clubLocation}
					</p>


					<div class="mb-3"
						style="background: #fff3e6; border-radius: 12px; padding: 10px; font-weight: 700; color: #b36200;">

						${dto.currentMember} / ${dto.clubMax} 명</div>

					<c:choose>

						<c:when test="${isMember}">
							<a href="/clubChat/room?clubNum=${dto.clubNum}"
								class="btn btn-sm btn-brown btn-block mt-2"> 채팅하기 </a>
						</c:when>

						<c:otherwise>
							<button type="button" class="btn btn-sm btn-brown btn-block mt-2"
								onclick="alert('동호회 가입 회원만 채팅 가능합니다.');">채팅하기</button>
						</c:otherwise>

					</c:choose>

					<c:if test="${not empty dto.clubContents}">
						<hr>

						<p
							style="color: #5f4b3b; line-height: 1.6; font-size: 14px; margin-bottom: 0;">

							${dto.clubContents}</p>
					</c:if>

				</div>
			</div>

			<!-- 가운데 게시판 -->
			<div class="col-lg-6 mb-4 center-board">

				<div class="main-card p-3" id="boardArea">

					<div class="position-relative mb-4 text-center">

						<h3 class="section-title mb-0">${dto.clubName}게시판</h3>

						<a href="../clubboard/create?clubNum=${dto.clubNum}"
							class="btn btn-sm btn-brown"
							style="position: absolute; right: 0; top: 50%; transform: translateY(-50%);">
							글쓰기 </a>

					</div>

					<table class="table">

						<thead>
							<tr>
								<th style="width: 20%;">작성자</th>
								<th>제목</th>
								<th style="width: 26%;">등록일</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${boardList}" var="boardDTO">
								<tr>
									<td>${boardDTO.memberName}</td>

									<td><span class="badge badge-success"
										style="font-size: 10px; padding: 3px 6px; margin-right: 5px;">
											${boardDTO.boardCategory} </span> <a
										href="../clubboard/detail?boardNum=${boardDTO.boardNum}&clubNum=${dto.clubNum}"
										class="board-title-link"> ${boardDTO.boardTitle} </a> <c:if
											test="${boardDTO.fileCount > 0}">
											<span
												style="font-size: 13px; margin-left: 5px; color: #8c7b6d;">
												🖼 </span>
										</c:if> <c:if test="${boardDTO.commentCount > 0}">
											<span
												style="color: #b36200; font-weight: 700; margin-left: 4px;">
												(${boardDTO.commentCount}) </span>
										</c:if></td>

									<td>
										${fn:replace(fn:substring(boardDTO.createDate.toString(), 0, 16), 'T', ' ')}
									</td>
								</tr>
							</c:forEach>

							<c:if test="${empty boardList}">
								<tr>
									<td colspan="3" class="text-center py-4">등록된 게시글이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>

					</table>

					<c:if test="${not empty boardList}">

						<nav aria-label="Page navigation example">

							<ul class="pagination justify-content-center mb-0">

								<c:if test="${pager.pre}">
									<li class="page-item"><a class="page-link"
										href="./detail?clubNum=${dto.clubNum}&page=${pager.start-1}#boardArea"
										style="background-color: #f1f1f1; color: #333; border: none; border-radius: 10px; margin: 0 3px;">
											이전 </a></li>
								</c:if>

								<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
									<li class="page-item"><a class="page-link"
										href="./detail?clubNum=${dto.clubNum}&page=${i}#boardArea"
										style="
											background-color: ${pager.page eq i ? '#ff8a00' : '#f1f1f1'};
											color: ${pager.page eq i ? 'white' : '#333'};
											border: none;
											border-radius: 10px;
											margin: 0 3px;">
											${i} </a></li>
								</c:forEach>

								<c:if test="${pager.next}">
									<li class="page-item"><a class="page-link"
										href="./detail?clubNum=${dto.clubNum}&page=${pager.end+1}#boardArea"
										style="background-color: #f1f1f1; color: #333; border: none; border-radius: 10px; margin: 0 3px;">
											다음 </a></li>
								</c:if>

							</ul>

						</nav>

					</c:if>

				</div>

			</div>

			<!-- 오른쪽 사이드바 -->
			<div class="col-lg-3 mb-4 right-side">

				<div class="side-card p-3 mb-2">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h5 class="section-title mb-0">일정</h5>

						<sec:authorize access="isAuthenticated()">

							<a href="../clubSchedule/create?clubNum=${dto.clubNum}"
								class="btn btn-sm btn-brown"> 일정 등록 </a>

						</sec:authorize>
					</div>

					<c:forEach items="${scheduleList}" var="schedule">

						<div class="schedule-item">
							<div class="schedule-date">
								${fn:substring(schedule.scheduleStart.toString(), 0, 10)}</div>

							<div class="schedule-title">
								<a
									href="../clubSchedule/detail?scheduleNum=${schedule.scheduleNum}"
									class="board-title-link"> ${schedule.scheduleTitle} </a>
							</div>

							<div class="text-muted" style="font-size: 13px;">
								${schedule.scheduleLocation}</div>
						</div>

					</c:forEach>

					<c:if test="${empty scheduleList}">
						<p class="text-muted mb-0">등록된 일정이 없습니다.</p>
					</c:if>

					<a href="../clubSchedule/list?clubNum=${dto.clubNum}"
						class="btn btn-sm btn-gray btn-block mt-3"> 전체 일정 보기 </a>
				</div>

				<div class="side-card p-3">
					<div class="d-flex justify-content-between align-items-center mb-3">
						<h5 class="section-title mb-0">공지</h5>

						<a
							href="../clubboard/create?clubNum=${dto.clubNum}&boardCategory=공지"
							class="btn btn-sm btn-brown"> 공지 등록 </a>
					</div>

					<c:choose>
						<c:when test="${not empty noticeList}">
							<c:forEach items="${noticeList}" var="notice">
								<a
									href="../clubboard/detail?boardNum=${notice.boardNum}&clubNum=${dto.clubNum}"
									class="notice-item"> ${notice.boardTitle} </a>
							</c:forEach>
						</c:when>

						<c:otherwise>
							<p class="text-muted mb-0">등록된 공지가 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</div>

			</div>

		</div>
</body>
</html>