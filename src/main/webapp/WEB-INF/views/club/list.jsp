<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동호회 목록</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>

<body>

	<div class="container mt-5">

		<h1 class="mb-4">동호회 목록</h1>

		<div class="dropdown">
			<a class="btn btn-secondary dropdown-toggle" href="#" role="button"
				data-toggle="dropdown" aria-expanded="false"> 카테고리 </a>

			<div class="dropdown-menu">
				<a class="dropdown-item" href="./list">전체</a> <a
					class="dropdown-item" href="./list?clubCategory=맛집">맛집</a> <a
					class="dropdown-item" href="./list?clubCategory=여행">여행</a> <a
					class="dropdown-item" href="./list?clubCategory=음악">음악</a> <a
					class="dropdown-item" href="./list?clubCategory=스터디">스터디</a> <a
					class="dropdown-item" href="./list?clubCategory=기타">기타</a> <a
					class="dropdown-item" href="./list?clubCategory=운동">운동</a>
			</div>
		</div>

		<div class="row">

			<c:forEach items="${list}" var="dto">

				<div class="col-md-4 mb-4">

					<div class="card h-100" style="width: 18rem;">

						<a href="./detail?clubNum=${dto.clubNum}&page=${pager.page}"
							style="text-decoration: none; color: inherit;"> <c:if
								test="${not empty dto.fileDTO}">
								<img src="/files/club/${dto.fileDTO.fileName}"
									class="card-img-top" alt="${dto.clubName}">
							</c:if>

							<div class="card-body">
								<h5 class="card-title">${dto.clubName}</h5>

								<p class="card-text">카테고리 : ${dto.clubCategory}</p>

								<p class="card-text">지역 : ${dto.clubLocation}</p>

								<p class="card-text">회원수 : ${dto.currentMember} / ${dto.clubMax}명</p>
							</div>

						</a>

					</div>

				</div>

			</c:forEach>

		</div>

		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center mt-4">

				<c:if test="${pager.pre}">
					<li class="page-item"><a class="page-link"
						href="./list?page=${pager.start - 1}&clubCategory=${param.clubCategory}">
							Previous </a></li>
				</c:if>

				<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
					<li class="page-item ${pager.page eq i ? 'active' : ''}"><a
						class="page-link"
						href="./list?page=${i}&clubCategory=${param.clubCategory}">
							${i} </a></li>
				</c:forEach>

				<c:if test="${pager.next}">
					<li class="page-item"><a class="page-link"
						href="./list?page=${pager.end + 1}&clubCategory=${param.clubCategory}">
							Next </a></li>
				</c:if>

			</ul>
		</nav>

	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
</body>
</html>