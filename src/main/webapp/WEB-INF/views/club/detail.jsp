<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

</head>

<body style="background-color: #fff7f3;">

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

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container mt-5" style="max-width: 1120px;">

		<div class="d-flex justify-content-between align-items-center mb-3">

			<h1 style="font-weight: 700;">${dto.clubName}</h1>

			<div>
				<form action="/clubMember/join" method="post"
					style="display: inline;">

					<input type="hidden" name="clubNum" value="${dto.clubNum}">

					<button type="submit" class="btn btn-sm"
						style="background-color: #b36200; color: white; border-radius: 12px; padding: 6px 16px; border: none;">

						가입하기</button>

				</form>
				<a href="./list?page=${param.page}" class="btn btn-sm"
					style="background-color: #8c7b6d; color: white; border-radius: 12px; padding: 6px 16px;">
					뒤로가기 </a>
			</div>

		</div>

		<hr>

		<div class="row align-items-start mb-4">

			<div class="col-md-6">

				<span class="badge badge-success mb-3"> ${dto.clubCategory} </span>

				<p class="mt-3">지역 : ${dto.clubLocation}</p>

				<p>회원수 : ${dto.currentMember} / ${dto.clubMax}</p>

			</div>

			<div class="col-md-6 text-right">

				<c:if test="${not empty dto.fileDTO}">
					<img src="/files/club/${dto.fileDTO.fileName}"
						alt="${dto.clubName}"
						style="width: 100%; max-width: 420px; height: 230px; object-fit: cover; border-radius: 20px;">
				</c:if>

			</div>

		</div>

		<hr>

		<div class="d-flex justify-content-between align-items-center mb-3">

			<h2 style="font-weight: 700;">${dto.clubName}게시판</h2>

			<a href="../clubboard/create?clubNum=${dto.clubNum}"
				class="btn btn-sm"
				style="background-color: #b36200; color: white; border-radius: 12px; padding: 6px 16px;">
				글쓰기 </a>

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

						<td><span class="badge badge-success"
							style="font-size: 10px; padding: 3px 6px; margin-right: 5px;">
								${boardDTO.boardCategory} </span> <a
							href="../clubboard/detail?boardNum=${boardDTO.boardNum}&clubNum=${dto.clubNum}"
							style="color: #a85b00; text-decoration: none;">
								${boardDTO.boardTitle} </a></td>

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

				<ul class="pagination justify-content-center">

					<c:if test="${pager.pre}">
						<li class="page-item"><a class="page-link"
							href="./detail?clubNum=${dto.clubNum}&page=${pager.start-1}"
							style="background-color: #f1f1f1; color: #333; border: none; border-radius: 10px; margin: 0 3px;">
								이전 </a></li>
					</c:if>

					<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
						<li class="page-item"><a class="page-link"
							href="./detail?clubNum=${dto.clubNum}&page=${i}"
							style="
							background-color: ${pager.page eq i ? '#ff8a00' : '#f1f1f1'};
							color: ${pager.page eq i ? 'white' : '#333'};
							border: none;
							border-radius: 10px;
							margin: 0 3px;
						">
								${i} </a></li>
					</c:forEach>

					<c:if test="${pager.next}">
						<li class="page-item"><a class="page-link"
							href="./detail?clubNum=${dto.clubNum}&page=${pager.end+1}"
							style="background-color: #f1f1f1; color: #333; border: none; border-radius: 10px; margin: 0 3px;">
								다음 </a></li>
					</c:if>

				</ul>

			</nav>

		</c:if>

	</div>

</body>
</html>