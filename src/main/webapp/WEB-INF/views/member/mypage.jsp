<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/common.css">
<style>

</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="my-page-wrap">

		<h2 class="page-title">마이페이지</h2>

		<div class="profile-card">
			<h4 class="section-title">내 정보</h4>

			<p class="info-text">
				<strong>이름</strong> : ${detail.memberName}
			</p>

			<p class="info-text">
				<strong>아이디</strong> : ${detail.memberId}
			</p>

			<p class="info-text">
				<strong>이메일</strong> : ${detail.memberEmail}
			</p>

			<a href="/member/detail" class="btn btn-brown mt-2">회원정보 상세</a>
		</div>

		<div class="section-card">
			<h4 class="section-title">최근 알림</h4>

			<c:choose>
				<c:when test="${not empty notificationList}">
					<c:forEach items="${notificationList}" var="noti">
						<div class="item-row">
							<div>
								<div class="item-title">${noti.notificationContents}</div>

								<div class="item-sub">
									${fn:replace(fn:substring(noti.createDate, 0, 16), 'T', ' ')}</div>
							</div>

							<a
								href="/notification/read?notificationNum=${noti.notificationNum}"
								class="btn btn-sm btn-brown"> 확인 </a>
						</div>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<p class="empty-text">최근 알림이 없습니다.</p>
				</c:otherwise>
			</c:choose>

			<div class="text-right mt-3">
				<a href="/notification/list"
					class="btn btn-sm btn-outline-secondary"> 전체보기 </a>
			</div>
		</div>

		<div class="section-card">
			<h4 class="section-title">내 동호회</h4>

			<c:choose>
				<c:when test="${not empty myClubList}">
					<c:forEach items="${myClubList}" var="club" begin="0" end="4">
						<div class="item-row">
							<div>
								<div class="item-title">${club.clubName}</div>
								<div class="item-sub">${club.clubCategory}·
									${club.clubLocation}</div>
							</div>

							<a href="/club/detail?clubNum=${club.clubNum}"
								class="btn btn-sm btn-brown"> 보기 </a>
						</div>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<p class="empty-text">가입한 동호회가 없습니다.</p>
				</c:otherwise>
			</c:choose>
			<div class="text-right mt-3">
				<!-- 내 동호회 전체보기 -->
				<a href="/club/myClubList" class="btn btn-sm btn-outline-secondary">
					전체보기 </a>
			</div>
		</div>

		<div class="section-card">
			<h4 class="section-title">내가 쓴 동호회 게시글</h4>

			<c:choose>
				<c:when test="${not empty myBoardList}">
					<c:forEach items="${myBoardList}" var="board" begin="0" end="4">
						<div class="item-row">
							<div>
								<div class="item-title">[${board.boardCategory}]
									${board.boardTitle}</div>
								<div class="item-sub">${board.clubName}</div>
							</div>

							<a
								href="/clubboard/detail?boardNum=${board.boardNum}&clubNum=${board.clubNum}"
								class="btn btn-sm btn-brown"> 보기 </a>
						</div>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<p class="empty-text">작성한 게시글이 없습니다.</p>
				</c:otherwise>
			</c:choose>
			<div class="text-right mt-3">
				<a href="/clubboard/myBoardList"
					class="btn btn-sm btn-outline-secondary"> 전체보기 </a>
			</div>

		</div>


		<div class="section-card">
			<h4 class="section-title">내가 등록한 알바 공고</h4>

			<c:choose>
				<c:when test="${not empty myJobList}">
					<c:forEach items="${myJobList}" var="job" begin="0" end="4">
						<div class="item-row">
							<div>
								<div class="item-title">${job.jobTitle}</div>
								<div class="item-sub">${job.jobCategory}·
									${job.jobLocation}</div>
							</div>

							<a href="/job/detail?jobNum=${job.jobNum}"
								class="btn btn-sm btn-brown"> 보기 </a>
						</div>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<p class="empty-text">등록한 알바 공고가 없습니다.</p>
				</c:otherwise>
			</c:choose>
			<div class="text-right mt-3">
				<!-- 내가 등록한 알바 공고 전체보기 -->
				<a href="/job/myJobList" class="btn btn-sm btn-outline-secondary">
					전체보기 </a>
			</div>
		</div>

		<div class="section-card">
			<h4 class="section-title">내가 지원한 알바</h4>

			<c:choose>
				<c:when test="${not empty myApplyList}">
					<c:forEach items="${myApplyList}" var="apply" begin="0" end="4">
						<div class="item-row">
							<div>
								<div class="item-title">${apply.jobTitle}</div>
								<div class="item-sub">지원 상태 : ${apply.applyStatus}</div>
							</div>

							<a href="/job/detail?jobNum=${apply.jobNum}"
								class="btn btn-sm btn-brown"> 보기 </a>
						</div>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<p class="empty-text">지원한 알바가 없습니다.</p>
				</c:otherwise>
			</c:choose>
			<div class="text-right mt-3">
				<!-- 내가 지원한 알바 전체보기 -->
				<a href="/jobApply/myList" class="btn btn-sm btn-outline-secondary">
					전체보기 </a>
			</div>
		</div>

	</div>

    <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
</body>
</html>