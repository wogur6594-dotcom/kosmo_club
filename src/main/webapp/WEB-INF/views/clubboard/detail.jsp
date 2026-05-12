<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

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

		<h1>${dto.boardTitle}</h1>

		<hr>

		<div class="mb-3">

			<p>
				<strong>작성자 :</strong> ${dto.boardWriter}
			</p>

			<p>
				<strong>카테고리 :</strong> ${dto.boardCategory}
			</p>

			<p>
				<strong>작성일 :</strong> ${dto.createDate}
			</p>

		</div>

		<hr>

		<hr>
		<h5>첨부 이미지</h5>

		<c:forEach items="${dto.list}" var="file">
			<img src="/clubboard/${file.fileName}" class="img-fluid mb-3"
				style="max-width: 400px;">
		</c:forEach>
		<hr>
		<c:forEach items="${dto.list}" var="file">
		</c:forEach>


		<div class="p-3 border rounded bg-light" style="min-height: 200px;">




			${dto.boardContents}</div>



		<div class="mt-4">

			<a href="/club/detail?clubNum=${dto.clubNum}"
				class="btn btn-secondary"> 동호회로 돌아가기 </a>

		</div>

	</div>

</body>
</html>