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

<link rel="stylesheet" href="/css/restaurant.css?v=13">
</head>

<body>
	<c:if test="${not empty message}">
		<script>
		alert("${message}");
	</script>
	</c:if>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container restaurant-wrap">

		<div class="filter-wrap">
			<div class="top-box">
				<div class="category-filter">

					<a href="./list"
						class="category-btn ${empty pager.search ? 'active' : ''}"> 전체
					</a> <a href="./list?search=한식"
						class="category-btn ${pager.search eq '한식' ? 'active' : ''}">
						한식 </a> <a href="./list?search=중식"
						class="category-btn ${pager.search eq '중식' ? 'active' : ''}">
						중식 </a> <a href="./list?search=일식"
						class="category-btn ${pager.search eq '일식' ? 'active' : ''}">
						일식 </a> <a href="./list?search=양식"
						class="category-btn ${pager.search eq '양식' ? 'active' : ''}">
						양식 </a> <a href="./list?search=카페"
						class="category-btn ${pager.search eq '카페' ? 'active' : ''}">
						카페 </a> <a href="./list?search=디저트"
						class="category-btn ${pager.search eq '디저트' ? 'active' : ''}">
						디저트 </a> <a href="./list?search=술집"
						class="category-btn ${pager.search eq '술집' ? 'active' : ''}">
						술집 </a> <a href="./list?search=치킨"
						class="category-btn ${pager.search eq '치킨' ? 'active' : ''}">
						치킨 </a> <a href="./list?search=분식"
						class="category-btn ${pager.search eq '분식' ? 'active' : ''}">
						분식 </a>

				</div>
			</div>
			<div class="restaurant-actions">

				<form action="./list" method="get" class="search-form">
					<input type="text" name="search" value="${pager.search}"
						class="form-control search-input" placeholder="맛집 검색">

					<button class="btn btn-brown">검색</button>
				</form>

				<a href="./create" class="btn btn-brown"> 맛집 등록 </a>

			</div>

			<div class="nearby-row">
				<button type="button" class="btn btn-brown" id="nearbyBtn">
					📍 내 주변 맛집</button>
				<div class="distance-filter-box">
					<button type="button" class="distance-filter-btn active"
						data-range="all">전체</button>
					<button type="button" class="distance-filter-btn" data-range="1">1km
						이내</button>
					<button type="button" class="distance-filter-btn" data-range="3">3km
						이내</button>
					<button type="button" class="distance-filter-btn" data-range="5">5km
						이내</button>
				</div>
			</div>
			<div class="sort-row">

				<button type="button" class="sort-btn active" data-sort="distance">
					가까운순</button>

				<button type="button" class="sort-btn" data-sort="score">
					평점순</button>

				<button type="button" class="sort-btn" data-sort="hit">조회순
				</button>

			</div>

		</div>

		<div id="filterStatusText" class="filter-status-text"
			data-category="${pager.search}">전체 맛집을 가까운순으로 보고 있어요</div>

		<div id="emptyDistanceMessage" class="empty-distance-message">
			해당 거리 안에 표시할 맛집이 없습니다.</div>


		<div class="restaurant-grid" id="restaurantGrid">

			<c:choose>

				<c:when test="${empty list}">

					<div class="empty-restaurant-list">등록된 맛집이 없습니다.</div>

				</c:when>

				<c:otherwise>

					<c:forEach items="${list}" var="dto">

						<div class="restaurant-card" data-lat="${dto.restaurantLat}"
							data-lng="${dto.restaurantLng}" data-score="${dto.avgScore}"
							data-hit="${dto.hit}">

							<a
								href="./detail?restaurantNum=${dto.restaurantNum}&page=${pager.page}&search=${pager.search}"
								class="restaurant-link">

								<div class="thumb-box">

									<c:set var="defaultImage" value="/image/default-restaurant.jpg" />

									<c:if test="${dto.restaurantCategory eq '한식'}">
										<c:set var="defaultImage" value="/image/default-korean.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '중식'}">
										<c:set var="defaultImage" value="/image/default-chinese.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '일식'}">
										<c:set var="defaultImage" value="/image/default-japanese.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '양식'}">
										<c:set var="defaultImage" value="/image/default-western.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '카페'}">
										<c:set var="defaultImage" value="/image/default-cafe.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '디저트'}">
										<c:set var="defaultImage" value="/image/default-dessert.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '술집'}">
										<c:set var="defaultImage" value="/image/default-bar.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '치킨'}">
										<c:set var="defaultImage" value="/image/default-chicken.jpg" />
									</c:if>

									<c:if test="${dto.restaurantCategory eq '분식'}">
										<c:set var="defaultImage" value="/image/default-snack.jpg" />
									</c:if>

									<c:choose>

										<c:when test="${not empty dto.fileDTOs}">
											<img src="/files/restaurant/${dto.fileDTOs[0].fileName}"
												onerror="this.onerror=null; this.src='${defaultImage}';">
										</c:when>

										<c:otherwise>
											<img src="${defaultImage}">
										</c:otherwise>

									</c:choose>

								</div>

								<div class="card-body">

									<div class="restaurant-name">${dto.restaurantName}</div>

									<div
										class="restaurant-category
	<c:if test="${dto.restaurantCategory eq '한식'}">category-korean</c:if>
	<c:if test="${dto.restaurantCategory eq '중식'}">category-chinese</c:if>
	<c:if test="${dto.restaurantCategory eq '일식'}">category-japanese</c:if>
	<c:if test="${dto.restaurantCategory eq '양식'}">category-western</c:if>
	<c:if test="${dto.restaurantCategory eq '카페'}">category-cafe</c:if>
	<c:if test="${dto.restaurantCategory eq '디저트'}">category-dessert</c:if>
	<c:if test="${dto.restaurantCategory eq '술집'}">category-bar</c:if>
	<c:if test="${dto.restaurantCategory eq '치킨'}">category-chicken</c:if>
	<c:if test="${dto.restaurantCategory eq '분식'}">category-snack</c:if>
">
										${dto.restaurantCategory}</div>

									<div class="info-text">📍 ${dto.restaurantLocation}</div>

									<div class="restaurant-meta-row">

										<div class="meta-badge distance restaurant-distance">📍
											거리 계산 전</div>

										<div class="meta-badge score">
											⭐
											<fmt:formatNumber value="${dto.avgScore}" pattern="0.0" />
											(${dto.reviewCount})
										</div>

										<div class="meta-badge hit">👀 ${dto.hit}</div>

									</div>

									<div class="info-text mt-2">작성자 : ${dto.memberName}</div>
								</div>

							</a>

						</div>

					</c:forEach>


				</c:otherwise>

			</c:choose>
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
						href="./list?page=${pager.end+1}&search=${pager.search}"> 다음 </a></li>
				</c:if>

			</ul>
		</nav>

	</div>

	<script>
	
	const sortBtns = document.querySelectorAll(".sort-btn");

	sortBtns.forEach(function(btn) {

		btn.addEventListener("click", function() {

			sortBtns.forEach(function(item) {
				item.classList.remove("active");
			});

			btn.classList.add("active");

			const type = btn.dataset.sort;

			sortRestaurantCards(type);
			applyCurrentDistanceFilter();
			updateFilterStatusText();
		});
	});
	
	document.addEventListener("DOMContentLoaded", function() {
		calculateDistance(true);
		updateFilterStatusText();
	});

	const nearbyBtn = document.querySelector("#nearbyBtn");

	if (nearbyBtn) {
		nearbyBtn.addEventListener("click", function() {
			calculateDistance(true);
		});
	}

	const filterBtns = document.querySelectorAll(".distance-filter-btn");

	filterBtns.forEach(function(btn) {
		btn.addEventListener("click", function() {

			filterBtns.forEach(function(item) {
				item.classList.remove("active");
			});

			btn.classList.add("active");

			const range = btn.dataset.range;
			filterByDistance(range);
			updateFilterStatusText();
		});
	});

	function calculateDistance(sortAfter) {

		if (!navigator.geolocation) {
			return;
		}

		navigator.geolocation.getCurrentPosition(
			function(position) {

				const userLat = position.coords.latitude;
				const userLng = position.coords.longitude;

				const cards = document.querySelectorAll(".restaurant-card");

				cards.forEach(function(card) {

					const lat = parseFloat(card.dataset.lat);
					const lng = parseFloat(card.dataset.lng);
					const distanceBox = card.querySelector(".restaurant-distance");

					if (isNaN(lat) || isNaN(lng)) {
						card.dataset.distance = "999999";
						distanceBox.innerText = "📍 거리 정보 없음";
						return;
					}

					const distance = getDistance(userLat, userLng, lat, lng);

					card.dataset.distance = distance;

					if (distance < 1) {
						distanceBox.innerText = "📍 약 " + Math.round(distance * 1000) + "m";
					} else {
						distanceBox.innerText = "📍 약 " + distance.toFixed(1) + "km";
					}
				});

				if (sortAfter) {
					sortRestaurantCards();
				}

				const activeBtn = document.querySelector(".distance-filter-btn.active");
				if (activeBtn) {
					filterByDistance(activeBtn.dataset.range);
				}
			},
			function(error) {
				console.log(error);
			},
			{
				enableHighAccuracy: true,
				timeout: 10000,
				maximumAge: 0
			}
		);
	}

	function filterByDistance(range) {
		const cards = document.querySelectorAll(".restaurant-card");
		const emptyMessage = document.querySelector("#emptyDistanceMessage");

		let visibleCount = 0;

		cards.forEach(function(card) {
			const distance = parseFloat(card.dataset.distance);

			if (range === "all") {
				card.style.display = "";
				visibleCount++;
				return;
			}

			if (!isNaN(distance) && distance <= parseFloat(range)) {
				card.style.display = "";
				visibleCount++;
			} else {
				card.style.display = "none";
			}
		});

		if (emptyMessage) {

			const totalCards = document.querySelectorAll(".restaurant-card").length;

			if (totalCards > 0 && visibleCount === 0) {
				emptyMessage.style.display = "block";
			} else {
				emptyMessage.style.display = "none";
			}
		}
	}

	function applyCurrentDistanceFilter() {

		const activeFilterBtn = document.querySelector(".distance-filter-btn.active");

		if (!activeFilterBtn) {
			return;
		}

		filterByDistance(activeFilterBtn.dataset.range);
	}

	function updateFilterStatusText() {

		const statusBox = document.querySelector("#filterStatusText");

		if (!statusBox) {
			return;
		}

		const activeDistanceBtn = document.querySelector(".distance-filter-btn.active");
		const activeSortBtn = document.querySelector(".sort-btn.active");

		let categoryText = statusBox.dataset.category;
		let distanceText = "전체";
		let sortText = "가까운순";

		if (!categoryText || categoryText.trim() === "") {
			categoryText = "전체";
		}

		if (activeDistanceBtn) {
			distanceText = activeDistanceBtn.innerText.trim();
		}

		if (activeSortBtn) {
			sortText = activeSortBtn.innerText.trim();
		}

		if (categoryText === "전체" && distanceText === "전체") {

			statusBox.innerText =
				"전체 맛집을 " + sortText + "으로 보고 있어요";

		} else if (categoryText !== "전체" && distanceText === "전체") {

			statusBox.innerText =
				categoryText + " 맛집을 " + sortText + "으로 보고 있어요";

		} else if (categoryText === "전체" && distanceText !== "전체") {

			statusBox.innerText =
				distanceText + " 맛집을 " + sortText + "으로 보고 있어요";

		} else {

			statusBox.innerText =
				categoryText + " · " +
				distanceText + " 맛집을 " +
				sortText + "으로 보고 있어요";
		}
	}
	
	function sortRestaurantCards(type = "distance") {

		const grid = document.querySelector("#restaurantGrid");

		if (!grid) {
			return;
		}

		const cards = Array.from(grid.querySelectorAll(".restaurant-card"));

		cards.sort(function(a, b) {

			if (type === "score") {

				const scoreA = parseFloat(a.dataset.score) || 0;
				const scoreB = parseFloat(b.dataset.score) || 0;

				return scoreB - scoreA;
			}

			if (type === "hit") {

				const hitA = parseInt(a.dataset.hit) || 0;
				const hitB = parseInt(b.dataset.hit) || 0;

				return hitB - hitA;
			}

			const distanceA = parseFloat(a.dataset.distance) || 999999;
			const distanceB = parseFloat(b.dataset.distance) || 999999;

			return distanceA - distanceB;
		});

		cards.forEach(function(card) {
			grid.appendChild(card);
		});
	}

	function getDistance(lat1, lon1, lat2, lon2) {
		const R = 6371;
		const dLat = deg2rad(lat2 - lat1);
		const dLon = deg2rad(lon2 - lon1);

		const a =
			Math.sin(dLat / 2) * Math.sin(dLat / 2) +
			Math.cos(deg2rad(lat1)) *
			Math.cos(deg2rad(lat2)) *
			Math.sin(dLon / 2) *
			Math.sin(dLon / 2);

		const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

		return R * c;
	}

	function deg2rad(deg) {
		return deg * (Math.PI / 180);
	}
</script>
</body>
</html>