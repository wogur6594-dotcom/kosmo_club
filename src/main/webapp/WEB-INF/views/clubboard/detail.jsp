<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
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

		<div class="d-flex align-items-center mb-3">

			<h1 class="mr-3 mb-0">${dto.boardTitle}</h1>

			<span class="badge badge-success"> ${dto.boardCategory} </span>

		</div>

		<hr>

		<div class="mb-3">

			<div class="d-flex justify-content-between mb-4">

				<div>
					<strong>작성자 :</strong> ${dto.boardWriter}
				</div>

				<div>
					<strong>작성일 :</strong> ${fn:replace(fn:substring(dto.boardDate, 0, 16), 'T', ' ')}
				</div>

			</div>

		</div>



		<hr>

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

			<a href="/clubboard/detail?clubNum=${dto.clubNum}"
				class="btn btn-secondary"> 동호회로 돌아가기 </a>

		</div>

	</div>

</body>
</html>