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

								<p class="card-text">정원 : ${dto.clubMax}명</p>
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
						href="./list?page=${pager.start - 1}">Previous</a></li>
				</c:if>

				<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
					<li class="page-item ${pager.page eq i ? 'active' : ''}"><a
						class="page-link" href="./list?page=${i}">${i}</a></li>
				</c:forEach>

				<c:if test="${pager.next}">
					<li class="page-item"><a class="page-link"
						href="./list?page=${pager.end + 1}">Next</a></li>
				</c:if>

			</ul>
		</nav>

	</div>

</body>
</html>