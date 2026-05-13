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

</head>
<body>
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
				<img src="/clubboard/${file.fileName}" class="img-fluid mb-3"
					style="max-width: 400px;">
			</c:forEach>
			<hr>
			<c:forEach items="${dto.list}" var="file">
			</c:forEach>


			<div class="p-3 border rounded bg-light" style="min-height: 200px;">




				${dto.boardContents}</div>


			<sec:authentication property="principal" var="member" />

<div class="mt-4 position-relative" style="height: 45px;">

	<a href="/club/detail?clubNum=${dto.clubNum}&page=${param.page}"
		class="btn btn-secondary">
		동호회로 돌아가기
	</a>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="member" />

		<div style="position: absolute; left: 50%; top: 0; transform: translateX(-50%);">

			<c:if test="${member.username eq dto.boardWriter}">
				<a href="./update?boardNum=${dto.boardNum}&clubNum=${dto.clubNum}"
					class="btn btn-sm btn-warning">
					수정
				</a>
			</c:if>

			<c:if test="${member.username eq dto.boardWriter || member.roleNum == 1}">
				<form action="./delete" method="post" style="display:inline;">
					<input type="hidden" name="boardNum" value="${dto.boardNum}">
					<input type="hidden" name="clubNum" value="${dto.clubNum}">

					<button type="submit"
						class="btn btn-sm btn-danger"
						onclick="return confirm('정말 삭제하시겠습니까?');">
						삭제
					</button>
				</form>
			</c:if>

		</div>
	</sec:authorize>

</div>
</body>
</html>