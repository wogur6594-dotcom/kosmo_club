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

<link rel="stylesheet" href="/css/common.css">

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
		<div class="club-top-header mb-4">

			<div class="text-center flex-grow-1">


				<h1 class="section-title mb-0">${dto.clubName}</h1>

			</div>

			<div class="club-top-buttons">
				<c:choose>

					<c:when test="${isMember}">
					</c:when>

					<c:when test="${isWaiting}">
						<button type="button" class="btn btn-sm btn-warning" disabled>
							가입 대기중</button>
					</c:when>

					<c:otherwise>

						<form action="${pageContext.request.contextPath}/clubMember/join"
							method="post" onsubmit="return confirm('이 동호회에 가입 신청하시겠습니까?');">

							<input type="hidden" name="clubNum" value="${dto.clubNum}">

							<button type="submit" class="btn btn-sm btn-brown">가입하기
							</button>

						</form>

					</c:otherwise>

				</c:choose>
				<!-- 가입승인 -->
				<c:if test="${roleNum eq 1}">
					<a href="/clubMember/waitList?clubNum=${dto.clubNum}"
						class="btn-top-gray club-top-link"> 가입 신청 목록 </a>
				</c:if>

				<c:if test="${roleNum eq 1}">
					<a href="/clubMember/memberList?clubNum=${dto.clubNum}"
						class="btn-top-gray club-top-link"> 회원 목록 </a>
				</c:if>

				<c:if test="${isMember and roleNum eq 2}">
					<form action="${pageContext.request.contextPath}/clubMember/leave"
						method="post" onsubmit="return confirm('정말 이 동호회에서 탈퇴하시겠습니까?');">

						<input type="hidden" name="clubNum" value="${dto.clubNum}">

						<button type="submit" class="btn-top-danger">탈퇴하기</button>
					</form>
				</c:if>

				<a href="./list?page=${param.page}"
					class="btn-top-gray club-top-link"> 목록으로 </a>



			</div>

		</div>

		<div class="row">

			<!-- 왼쪽 사이드바 -->
			<div class="col-lg-3 mb-4 left-side">
				<div class="side-card p-3 mb-3">

					<c:if test="${not empty dto.fileDTO}">
						<c:choose>
							<c:when test="${fn:startsWith(dto.fileDTO.fileName, 'http')}">
								<img src="${dto.fileDTO.fileName}" alt="${dto.clubName}" class="club-image mb-3">
							</c:when>
							<c:otherwise>
								<img src="/files/club/${dto.fileDTO.fileName}" alt="${dto.clubName}" class="club-image mb-3">
							</c:otherwise>
						</c:choose>
					</c:if>

					<h5 class="section-title mb-3">동호회 정보</h5>

					<p class="mb-3">
						<span class="club-info-label">회장</span> · ${dto.ownerName}
					</p>
					<p class="mb-2">
						<span class="club-info-label">지역</span> · ${dto.clubLocation}
					</p>


					<div class="club-member-count mb-3">${dto.currentMember}/
						${dto.clubMax} 명</div>

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

						<p class="club-desc">${dto.clubContents}</p>
					</c:if>
					<c:if test="${canDelete}">
						<form action="./delete" method="post"
							onsubmit="return confirm('정말 삭제하시겠습니까?');">

							<input type="hidden" name="clubNum" value="${dto.clubNum}">

							<button type="submit" class="club-delete-btn">동호회 해체</button>

						</form>
					</c:if>
				</div>
			</div>

			<!-- 가운데 게시판 -->
			<div class="col-lg-6 mb-4 center-board">

				<div class="main-card p-3" id="boardArea">

					<div class="board-header mb-4">
						<h3 class="section-title mb-0">${dto.clubName}게시판</h3>

						<a href="../clubboard/create?clubNum=${dto.clubNum}"
							class="btn btn-sm btn-brown"> 글쓰기 </a>
					</div>

					<form action="./detail" method="get" class="mb-3">

						<input type="hidden" name="clubNum" value="${dto.clubNum}">
						<input type="hidden" name="sort" value="${pager.sort}">

						<div class="d-flex">

							<select name="kind" class="form-control search-control mr-2">

								<option value="title" ${pager.kind eq 'title' ? 'selected' : ''}>
									제목</option>



								<option value="contents"
									${pager.kind eq 'contents' ? 'selected' : ''}>내용</option>

								<option value="titleContents"
									${pager.kind eq 'titleContents' ? 'selected' : ''}>
									제목+내용</option>

								<option value="writer"
									${pager.kind eq 'writer' ? 'selected' : ''}>작성자</option>

								<option value="category"
									${pager.kind eq 'category' ? 'selected' : ''}>카테고리</option>

							</select> <input type="text" name="search" value="${pager.search}"
								class="form-control search-control mr-2" placeholder="검색어 입력">

							<button type="submit" class="btn btn-brown search-btn">검색</button>

						</div>

					</form>

					<!-- 정렬 -->
					<div class="board-filter-box d-flex flex-wrap align-items-center">

						<a
							href="./detail?clubNum=${dto.clubNum}&sort=latest&page=1&kind=${pager.kind}&search=${pager.search}#boardArea"
							class="btn btn-sm mr-2 ${empty pager.sort || pager.sort eq 'latest' ? 'btn-brown' : 'btn-gray'}">
							최신순 </a> <a
							href="./detail?clubNum=${dto.clubNum}&sort=hit&page=1&kind=${pager.kind}&search=${pager.search}#boardArea"
							class="btn btn-sm mr-2 ${pager.sort eq 'hit' ? 'btn-brown' : 'btn-gray'}">
							조회순 </a> <a
							href="./detail?clubNum=${dto.clubNum}&sort=comment&page=1&kind=${pager.kind}&search=${pager.search}#boardArea"
							class="btn btn-sm mr-2 ${pager.sort eq 'comment' ? 'btn-brown' : 'btn-gray'}">
							댓글순 </a> <a
							href="./detail?clubNum=${dto.clubNum}&sort=like&page=1&kind=${pager.kind}&search=${pager.search}#boardArea"
							class="btn btn-sm ${pager.sort eq 'like' ? 'btn-brown' : 'btn-gray'}">
							좋아요순 </a>

					</div>
					<!-- 정렬끝 -->

					<!-- 카테고리 필터 -->
					<div class="board-filter-box d-flex flex-wrap align-items-center">

						<a
							href="./detail?clubNum=${dto.clubNum}&page=1&sort=${pager.sort}#boardArea"
							class="btn btn-sm mr-2 ${empty pager.search ? 'btn-brown' : 'btn-gray'}">
							전체 </a> <a
							href="./detail?clubNum=${dto.clubNum}&page=1&sort=${pager.sort}&kind=category&search=자유#boardArea"
							class="btn btn-sm mr-2 ${pager.kind eq 'category' and pager.search eq '자유' ? 'btn-brown' : 'btn-gray'}">
							자유 </a> <a
							href="./detail?clubNum=${dto.clubNum}&page=1&sort=${pager.sort}&kind=category&search=공지#boardArea"
							class="btn btn-sm mr-2 ${pager.kind eq 'category' and pager.search eq '공지' ? 'btn-brown' : 'btn-gray'}">
							공지 </a> <a
							href="./detail?clubNum=${dto.clubNum}&page=1&sort=${pager.sort}&kind=category&search=일정#boardArea"
							class="btn btn-sm mr-2 ${pager.kind eq 'category' and pager.search eq '일정' ? 'btn-brown' : 'btn-gray'}">
							일정 </a> <a
							href="./detail?clubNum=${dto.clubNum}&page=1&sort=${pager.sort}&kind=category&search=후기#boardArea"
							class="btn btn-sm ${pager.kind eq 'category' and pager.search eq '후기' ? 'btn-brown' : 'btn-gray'}">
							후기 </a>

					</div>
					<!-- 카테고리 필터 끝 -->

					<div class="mb-3 px-2">

						총 ${pager.totalCount}개의 게시글 ·

						<c:choose>

							<c:when test="${pager.sort eq 'hit'}">
			조회순 정렬
		</c:when>

							<c:when test="${pager.sort eq 'comment'}">
			댓글순 정렬
		</c:when>

							<c:when test="${pager.sort eq 'like'}">
			좋아요순 정렬
		</c:when>

							<c:otherwise>
			최신순 정렬
		</c:otherwise>

						</c:choose>

					</div>

					<table class="table">

						<thead>
							<tr>
								<th>작성자</th>
								<th>제목</th>
								<th>등록일</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach items="${boardList}" var="boardDTO">
								<tr>
									<td>${boardDTO.memberName}</td>

									<td><span class="badge badge-success">
											${boardDTO.boardCategory} </span> <a
										href="../clubboard/detail?boardNum=${boardDTO.boardNum}&clubNum=${dto.clubNum}&page=${pager.page}&sort=${pager.sort}&kind=${pager.kind}&search=${pager.search}"
										class="board-title-link"> ${boardDTO.boardTitle} </a> <c:if
											test="${boardDTO.fileCount > 0}">
											<span> 🖼 </span>
										</c:if> <c:if test="${boardDTO.commentCount > 0}">
											<span> (${boardDTO.commentCount}) </span>
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
										href="./detail?clubNum=${dto.clubNum}&page=${pager.start-1}&sort=${pager.sort}&kind=${pager.kind}&search=${pager.search}#boardArea">
											이전 </a></li>
								</c:if>

								<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
									<li class="page-item"><a class="page-link"
										href="./detail?clubNum=${dto.clubNum}&page=${i}&sort=${pager.sort}&kind=${pager.kind}&search=${pager.search}#boardArea">
											${i} </a></li>
								</c:forEach>

								<c:if test="${pager.next}">
									<li class="page-item"><a class="page-link"
										href="./detail?clubNum=${dto.clubNum}&page=${pager.end+1}&sort=${pager.sort}&kind=${pager.kind}&search=${pager.search}#boardArea">
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

							<div class="text-muted">${schedule.scheduleLocation}</div>
						</div>

					</c:forEach>

					<c:if test="${empty scheduleList}">
						<p class="text-muted mb-0">등록된 일정이 없습니다.</p>
					</c:if>

					<a href="../clubSchedule/list?clubNum=${dto.clubNum}"
						class="btn btn-sm btn-gray btn-block mt-3"> 전체 일정 보기 </a>
				</div>

				<div class="side-card p-3 mb-2">

					<h5 class="section-title mb-3">🔥 인기글</h5>

					<c:choose>

						<c:when test="${empty popularList}">

							<p class="text-muted mb-0">아직 인기글이 없습니다.</p>

						</c:when>

						<c:otherwise>

							<c:forEach items="${popularList}" var="popular">

								<div class="mb-3 pb-2 border-bottom">

									<a
										href="../clubboard/detail?boardNum=${popular.boardNum}&clubNum=${dto.clubNum}&page=${pager.page}&sort=${pager.sort}&kind=${pager.kind}&search=${pager.search}"
										class="board-title-link"> ${popular.boardTitle} </a>

									<div class="small text-muted mt-1">❤ ${popular.likeCount}
										· 💬 ${popular.commentCount} · 👁 ${popular.hit}</div>

								</div>

							</c:forEach>

						</c:otherwise>

					</c:choose>

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
									href="../clubboard/detail?boardNum=${notice.boardNum}&clubNum=${dto.clubNum}&page=${pager.page}&sort=${pager.sort}&kind=${pager.kind}&search=${pager.search}"
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