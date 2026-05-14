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
	background-color: #f8f5f1;
}

.btn-soft-brown {
	background-color: #a35400;
	color: white;
	border: none;
	border-radius: 14px;
	padding: 10px 22px;
	font-weight: 600;
	transition: all 0.25s ease;
	box-shadow: 0 4px 12px rgba(163, 84, 0, 0.15);
}

.btn-soft-brown:hover {
	background-color: #8b4700;
	color: white;
	text-decoration: none;
	transform: translateY(-1px);
	box-shadow: 0 8px 18px rgba(163, 84, 0, 0.22);
}

.btn-soft-gray {
	background-color: #ebe3dc;
	color: #6f5b4c;
	border: none;
	border-radius: 14px;
	padding: 10px 22px;
	font-weight: 600;
	transition: all 0.25s ease;
}

.btn-soft-gray:hover {
	background-color: #ddd2c8;
	color: #4e4036;
	text-decoration: none;
	transform: translateY(-1px);
}

.btn-soft-red {
	background-color: #c95c54;
	color: white;
	border: none;
	border-radius: 14px;
	padding: 10px 22px;
	font-weight: 600;
	transition: all 0.25s ease;
}

.btn-soft-red:hover {
	background-color: #ae463f;
	color: white;
	transform: translateY(-1px);
}
</style>

</head>
<body>

	<c:if test="${not empty message}">
		<script>
			alert("${message}");
		</script>
	</c:if>


	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container mt-5">
		<div style="max-width: 1100px; margin: 0 auto;">

			<div class="d-flex align-items-center mb-3">

				<h1 class="mr-3 mb-0">${dto.boardTitle}</h1>

				<span class="badge badge-success"> ${dto.boardCategory} </span>

			</div>

			<hr>

			<div class="mb-3">

				<div class="d-flex justify-content-between mb-4">

					<div>
						<strong>작성자 :</strong> ${dto.memberName}
					</div>

					<div>
						<strong>등록일 :</strong>
						${fn:replace(fn:substring(dto.createDate.toString(), 0, 16), 'T', ' ')}
					</div>

				</div>

			</div>





			<c:forEach items="${dto.list}" var="file">
				<img
					src="${pageContext.request.contextPath}/files/clubboard/${file.fileName}"
					class="img-fluid mb-3" style="max-width: 400px;">
			</c:forEach>
			<hr>
			<c:forEach items="${dto.list}" var="file">
			</c:forEach>


			<div class="p-4 border rounded"
				style="min-height: 200px; background-color: #f3ebe4; border-color: #e2d6cc !important; color: #3d2b1f; line-height: 1.8; border-radius: 18px;">




				${dto.boardContents}</div>

			<!-- 댓글 -->



			<c:forEach items="${commentList}" var="comment">

				<div class="mb-3">

					<div>
						<span style="font-weight: 700;">${comment.memberName}</span> <span
							style="font-size: 12px; color: #888; margin-left: 8px;">
							${fn:replace(fn:substring(comment.createDate.toString(), 0, 16), 'T', ' ')}
						</span>
					</div>

					<div style="color: #444;">${comment.commentContents}</div>

				</div>

				<hr>

			</c:forEach>


			<h4 class="mt-5 mb-3">댓글</h4>

			<form action="/clubboardcomment/add" method="post">

				<input type="hidden" name="boardNum" value="${dto.boardNum}">

				<input type="hidden" name="clubNum" value="${dto.clubNum}">

				<textarea name="commentContents" class="form-control" rows="3"
					placeholder="댓글을 입력하세요"></textarea>

				<button type="submit" class="btn btn-sm mt-2"
					style="background-color: #b36200; color: white;">댓글 작성</button>

			</form>

			<!-- 댓글끝 -->




			<sec:authentication property="principal" var="member" />

			<div
				class="d-flex justify-content-between align-items-center mt-4 mb-5">

				<a href="/club/detail?clubNum=${dto.clubNum}&page=${param.page}"
					class="btn-soft-gray"> 동호회로 돌아가기 </a>

				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="member" />

					<div class="d-flex align-items-center" style="gap: 10px;">

						<c:if test="${member.username eq dto.boardWriter}">
							<a
								href="./update?boardNum=${dto.boardNum}&clubNum=${dto.clubNum}"
								class="btn-soft-brown"> 수정 </a>
						</c:if>

						<c:if
							test="${member.username eq dto.boardWriter || member.roleNum == 1}">
							<form action="./delete" method="post" style="margin: 0;"
								onsubmit="return confirm('정말 삭제하시겠습니까?');">

								<input type="hidden" name="boardNum" value="${dto.boardNum}">
								<input type="hidden" name="clubNum" value="${dto.clubNum}">

								<button type="submit" class="btn-soft-red">삭제</button>

							</form>
						</c:if>

					</div>
				</sec:authorize>

			</div>
</body>
</html>