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
<title>게시글 상세</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/common.css">
</head>

<body>

	<c:if test="${not empty message}">
		<script>
			alert("${message}");
		</script>
	</c:if>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="board-detail-wrap">

		<div class="board-detail-card">

			<div class="board-detail-header">

				<h1 class="board-detail-title">${dto.boardTitle}</h1>

				<span class="badge badge-success"> ${dto.boardCategory} </span>

			</div>

			<div class="board-detail-meta">

				<div class="board-detail-meta-item">
					<strong>작성자 :</strong> ${dto.memberName}
				</div>

				<div class="board-detail-meta-item">
					<strong>등록일 :</strong>
					<c:if test="${not empty dto.createDate}">
						${fn:replace(fn:substring(dto.createDate.toString(), 0, 16), 'T', ' ')}
					</c:if>
				</div>

				<div class="board-detail-meta-item">
					<strong>조회수 :</strong> ${dto.hit}
				</div>

			</div>

			<c:forEach items="${dto.list}" var="file">
				<c:choose>
					<c:when test="${not empty file.fileName and fn:startsWith(file.fileName, 'http')}">
						<img src="${file.fileName}" class="board-detail-image">
					</c:when>
					<c:otherwise>
						<img src="${pageContext.request.contextPath}/files/clubboard/${file.fileName}" class="board-detail-image">
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<div class="board-detail-content">${dto.boardContents}</div>

			<div class="board-like-area">

				<c:choose>

					<c:when test="${likeCheck == 0}">

						<form
							action="${pageContext.request.contextPath}/clubboard/like/add"
							method="post" class="inline-form">

							<input type="hidden" name="boardNum" value="${dto.boardNum}">

							<button type="submit" class="btn btn-outline-danger">❤
								좋아요 ${likeCount}</button>

						</form>

					</c:when>

					<c:otherwise>

						<form
							action="${pageContext.request.contextPath}/clubboard/like/delete"
							method="post" class="inline-form">

							<input type="hidden" name="boardNum" value="${dto.boardNum}">

							<button type="submit" class="btn btn-danger">❤ 좋아요 취소
								${likeCount}</button>

						</form>

					</c:otherwise>

				</c:choose>

			</div>

			<div class="comment-section">

				<h4 class="comment-section-title">댓글</h4>

				<c:choose>

					<c:when test="${not empty commentList}">

						<c:forEach items="${commentList}" var="comment">

							<div class="comment-item">

								<div>
									<span class="comment-writer"> ${comment.memberName} </span> 
									<span class="comment-date">
										<c:if test="${not empty comment.createDate}">
											${fn:replace(fn:substring(comment.createDate.toString(), 0, 16), 'T', ' ')}
										</c:if>
									</span>
								</div>

								<div class="comment-contents">${comment.commentContents}</div>

							</div>

						</c:forEach>

					</c:when>

					<c:otherwise>
						<p class="empty-text">아직 댓글이 없습니다.</p>
					</c:otherwise>

				</c:choose>

				<form action="/clubboardcomment/add" method="post"
					class="comment-form mt-4">

					<input type="hidden" name="boardNum" value="${dto.boardNum}">

					<input type="hidden" name="clubNum" value="${dto.clubNum}">

					<textarea name="commentContents" class="form-control"
						placeholder="댓글을 입력하세요"></textarea>

					<button type="submit" class="btn btn-brown mt-2">댓글 작성</button>

				</form>

			</div>

			<sec:authentication property="principal" var="member" />

			<div class="board-detail-actions">

				<a
					href="/club/detail?clubNum=${dto.clubNum}&page=${param.page}&kind=${param.kind}&search=${param.search}#boardArea"
					class="btn-soft-gray"> 동호회로 돌아가기 </a>

				<sec:authorize access="isAuthenticated()">

					<div class="board-action-right">

						<c:if test="${member.username eq dto.boardWriter}">

							<a
								href="./update?boardNum=${dto.boardNum}&clubNum=${dto.clubNum}"
								class="btn-soft-brown"> 수정 </a>

						</c:if>

						<c:if
							test="${member.username eq dto.boardWriter || member.roleNum == 1}">

							<form action="./delete" method="post" class="inline-form"
								onsubmit="return confirm('정말 삭제하시겠습니까?');">

								<input type="hidden" name="boardNum" value="${dto.boardNum}">

								<input type="hidden" name="clubNum" value="${dto.clubNum}">

								<button type="submit" class="btn-soft-red">삭제</button>

							</form>

						</c:if>

					</div>

				</sec:authorize>

			</div>

		</div>

	</div>

</body>
</html>