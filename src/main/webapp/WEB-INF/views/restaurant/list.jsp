<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네맛집</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/restaurant.css">

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container restaurant-wrap">

		<div class="top-box">
			<div class="category-filter">

				<a href="./list" class="category-btn"> 전체 </a> <a
					href="./list?search=한식" class="category-btn"> 한식 </a> <a
					href="./list?search=중식" class="category-btn"> 중식 </a> <a
					href="./list?search=일식" class="category-btn"> 일식 </a> <a
					href="./list?search=양식" class="category-btn"> 양식 </a> <a
					href="./list?search=카페" class="category-btn"> 카페 </a> <a
					href="./list?search=디저트" class="category-btn"> 디저트 </a> <a
					href="./list?search=술집" class="category-btn"> 술집 </a>

			</div>


			<div class="restaurant-actions">

				<form action="./list" method="get" class="search-form">

					<input type="text" name="search" value="${pager.search}"
						class="form-control search-input" placeholder="맛집 검색">

					<button class="btn btn-brown">검색</button>

				</form>

				<a href="./create" class="btn btn-brown"> 맛집 등록 </a>

			</div>

		</div>

		<div class="restaurant-grid">

			<c:forEach items="${list}" var="dto">

				<div class="restaurant-card">

					<a href="./detail?restaurantNum=${dto.restaurantNum}"
						class="restaurant-link">

						<div class="thumb-box">

							<c:choose>

								<c:when test="${not empty dto.fileDTOs}">

									<img src="/files/restaurant/${dto.fileDTOs[0].fileName}">

								</c:when>

								<c:otherwise>

									<div class="no-image">등록된 사진 없음</div>

								</c:otherwise>

							</c:choose>

						</div>

						<div class="card-body">

							<div class="restaurant-name">${dto.restaurantName}</div>

							<div class="restaurant-category">${dto.restaurantCategory}
							</div>

							<div class="info-text">📍 ${dto.restaurantLocation}</div>

							<div class="restaurant-score">
								⭐
								<fmt:formatNumber value="${dto.avgScore}" pattern="0.0" />
								(${dto.reviewCount})
							</div>

							<div class="info-text">작성자 : ${dto.memberName}</div>

							<div class="info-text">👀 조회수 ${dto.hit}</div>

						</div>

					</a>

				</div>

			</c:forEach>

		</div>

		<nav>
			<ul class="pagination">

				<c:if test="${pager.pre}">
					<li class="page-item"><a class="page-link"
						href="./list?page=${pager.start-1}&search=${pager.search}"> 이전
					</a></li>
				</c:if>

				<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
					<li class="page-item ${pager.page == i ? 'active' : ''}"><a
						class="page-link" href="./list?page=${i}&search=${pager.search}">
							${i} </a></li>
				</c:forEach>

				<c:if test="${pager.next}">
					<li class="page-item"><a class="page-link"
						href="./list?page=${pager.end+1}&search=${pager.search}"> 다음 </a>
					</li>
				</c:if>

			</ul>
		</nav>

	</div>

</body>
</html>