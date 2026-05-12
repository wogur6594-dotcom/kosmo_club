<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container mt-5">

		<div class="d-flex justify-content-between align-items-center">

			<h1>${dto.clubName}</h1>

			<div>
				<a href="" class="btn btn-primary btn-sm">가입하기</a> <a
					href="./list?page=${param.page}" class="btn btn-secondary btn-sm">뒤로가기</a>
			</div>

		</div>

		<hr>

		<p>카테고리 : ${dto.clubCategory}</p>
		<p>지역 : ${dto.clubLocation}</p>
		<p>회원수 : ${dto.currentMember} / ${dto.clubMax}</p>

		<hr>

		<div class="d-flex justify-content-between align-items-center">

			<h3>${dto.clubName}게시판</h3>

			<a href="/clubboard/create?clubNum=${param.clubNum}"
				class="btn btn-primary btn-sm"> 글쓰기 </a>

		</div>

		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>카테고리</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${boardList}" var="board">
					<tr>
						<td>${board.boardNum}</td>

						<td><a
							href="/clubboard/detail?clubNum=${param.clubNum}&boardNum=${board.boardNum}&page=${pager.page}">
								${board.boardTitle} </a></td>

						<td>${board.boardWriter}</td>
						<td>${board.boardCategory}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="d-flex justify-content-center">

			<!-- 왼쪽 빈 공간 -->
			<div style="width: 80px;"></div>

			<!-- 가운데 페이징 -->
			<nav>
				<ul class="pagination mb-0">

					<c:if test="${pager.pre}">
						<li class="page-item"><a class="page-link"
							href="./detail?clubNum=${param.clubNum}&page=${pager.start - 1}">
								이전 </a></li>
					</c:if>

					<c:forEach begin="${pager.start}" end="${pager.end}" var="i">

						<li class="page-item ${pager.page == i ? 'active' : ''}"><a
							class="page-link"
							href="./detail?clubNum=${param.clubNum}&page=${i}"> ${i} </a></li>

					</c:forEach>

					<c:if test="${pager.next}">
						<li class="page-item"><a class="page-link"
							href="./detail?clubNum=${param.clubNum}&page=${pager.end + 1}">
								다음 </a></li>
					</c:if>

				</ul>
			</nav>



		</div>

	</div>

</body>
</html>