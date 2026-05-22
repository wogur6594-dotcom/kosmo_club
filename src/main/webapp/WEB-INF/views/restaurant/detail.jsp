<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.restaurantName}</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/restaurant.css?v=22">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e471a42003e30980f383ed3f0acf423&libraries=services"></script>
</head>

<body>
	<c:if test="${not empty message}">
		<script>
			alert("${message}");
		</script>
	</c:if>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="restaurant-detail-wrap">

		<div class="restaurant-detail-box">

			<c:set var="defaultImage" value="/image/default-restaurant.jpg" />

			<c:if test="${fn:trim(dto.restaurantCategory) eq '한식'}">
				<c:set var="defaultImage" value="/image/default-korean.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '중식'}">
				<c:set var="defaultImage" value="/image/default-chinese.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '일식'}">
				<c:set var="defaultImage" value="/image/default-japanese.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '양식'}">
				<c:set var="defaultImage" value="/image/default-western.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '카페'}">
				<c:set var="defaultImage" value="/image/default-cafe.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '디저트'}">
				<c:set var="defaultImage" value="/image/default-dessert.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '술집'}">
				<c:set var="defaultImage" value="/image/default-bar.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '치킨'}">
				<c:set var="defaultImage" value="/image/default-chicken.jpg" />
			</c:if>

			<c:if test="${fn:trim(dto.restaurantCategory) eq '분식'}">
				<c:set var="defaultImage" value="/image/default-snack.jpg" />
			</c:if>

			<c:choose>
				<c:when test="${not empty dto.fileDTOs}">

					<div class="detail-slider-wrap">

						<button type="button" class="slider-btn slider-prev">‹</button>

						<div class="detail-slider">

							<c:forEach items="${dto.fileDTOs}" var="file">
								<div class="detail-slide-item">
									<img src="/files/restaurant/${file.fileName}"
										class="restaurant-detail-img"
										onerror="this.onerror=null; this.classList.add('default-detail-image'); this.src='${defaultImage}';">
								</div>
							</c:forEach>

						</div>

						<button type="button" class="slider-btn slider-next">›</button>

					</div>

				</c:when>

				<c:otherwise>

					<div class="detail-slider-wrap default-detail-image-wrap">
						<img src="${defaultImage}"
							class="restaurant-detail-img default-detail-image">
					</div>

				</c:otherwise>
			</c:choose>

			<div class="detail-body">

				<div class="detail-header-card">

					<div class="detail-title-row">

						<div>

							<h1 class="detail-title">${dto.restaurantName}</h1>

							<div
								class="detail-category
	<c:choose>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '한식'}">category-korean</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '중식'}">category-chinese</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '일식'}">category-japanese</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '양식'}">category-western</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '카페'}">category-cafe</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '디저트'}">category-dessert</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '술집'}">category-bar</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '치킨'}">category-chicken</c:when>
		<c:when test="${fn:trim(dto.restaurantCategory) eq '분식'}">category-snack</c:when>
	</c:choose>
">
								${dto.restaurantCategory}</div>

						</div>

						<div class="detail-save-badge">🍴 맛집</div>

					</div>

					<div class="detail-meta-row">

						<div class="detail-meta-badge score">
							⭐ <span class="avg-score"> <fmt:formatNumber
									value="${dto.avgScore}" pattern="0.0" />
							</span>
						</div>

						<div class="detail-meta-badge">
							📝 <span class="review-count">${dto.reviewCount}</span>
						</div>

						<div class="detail-meta-badge">👀 ${dto.hit}</div>

					</div>

					<div class="detail-info-list">

						<div class="detail-info-item">📍 ${dto.restaurantLocation}
							${dto.restaurantDetailAddress}</div>

						<div class="detail-info-item">📞 ${dto.restaurantPhone}</div>

						<div class="detail-info-item">🕒 ${dto.restaurantTime}</div>

						<div class="detail-info-item">작성자 : ${dto.memberName}</div>

					</div>

				</div>

				<div class="like-area">

					<button type="button" class="btn-like" id="likeBtn"
						data-num="${dto.restaurantNum}">

						<c:choose>
							<c:when test="${dto.liked}">
								❤️ 좋아요 취소
							</c:when>
							<c:otherwise>
								🤍 좋아요
							</c:otherwise>
						</c:choose>

					</button>

					<span class="like-count">좋아요 ${dto.likeCount}</span>

				</div>

				<div class="map-area">
					<h3 class="map-title">위치</h3>

					<div id="map"></div>

					<div class="map-address">📍 ${dto.restaurantLocation}
						${dto.restaurantDetailAddress}</div>

					<a id="kakaoMapLink" class="btn btn-back map-link" target="_blank">
						카카오맵에서 보기 </a>
				</div>

				<div class="detail-contents">${dto.restaurantContents}</div>

				<div class="review-area">

					<h3 class="review-title">리뷰</h3>

					<div class="review-sort-row">

						<button type="button" class="review-sort-btn active"
							data-sort="latest">최신순</button>

						<button type="button" class="review-sort-btn" data-sort="high">
							평점 높은순</button>

						<button type="button" class="review-sort-btn" data-sort="low">
							평점 낮은순</button>

					</div>

					<form id="reviewForm" action="/restaurantReview/add" method="post"
						class="review-form">


						<div class="review-list">

							<c:forEach items="${reviewList}" var="review">

								<div class="review-card" id="review-${review.reviewNum}"
									data-num="${review.reviewNum}"
									data-score="${review.reviewScore}">

									<div class="review-head">

										<div>
											<strong>${review.memberName}</strong> <span
												class="review-date">${review.createDateFormat}</span>
										</div>

										<div class="review-score-text">
											<c:choose>
												<c:when test="${review.reviewScore == 5}">⭐⭐⭐⭐⭐</c:when>
												<c:when test="${review.reviewScore == 4}">⭐⭐⭐⭐</c:when>
												<c:when test="${review.reviewScore == 3}">⭐⭐⭐</c:when>
												<c:when test="${review.reviewScore == 2}">⭐⭐</c:when>
												<c:otherwise>⭐</c:otherwise>
											</c:choose>
										</div>

									</div>

									<div class="review-contents">${review.reviewContents}</div>

									<c:if test="${member.memberNum eq review.memberNum}">

										<div class="review-btn-group">

											<button type="button" class="btn btn-sm btn-review-update"
												data-review-num="${review.reviewNum}"
												data-review-contents="${review.reviewContents}"
												data-review-score="${review.reviewScore}">수정</button>

											<button type="button" class="btn btn-sm btn-review-delete"
												data-review-num="${review.reviewNum}">삭제</button>

										</div>

									</c:if>

								</div>

							</c:forEach>

							<c:if test="${empty reviewList}">
								<div class="empty-review">아직 등록된 리뷰가 없습니다.</div>
							</c:if>

						</div>
				</div>
				<input type="hidden" name="restaurantNum"
					value="${dto.restaurantNum}">

				<div class="form-group">

					<label>평점</label>

					<div class="star-select">

						<label> <input type="radio" name="reviewScore" value="5"
							checked> <span>5점 ⭐⭐⭐⭐⭐</span>
						</label> <label> <input type="radio" name="reviewScore" value="4">
							<span>4점 ⭐⭐⭐⭐</span>
						</label> <label> <input type="radio" name="reviewScore" value="3">
							<span>3점 ⭐⭐⭐</span>
						</label> <label> <input type="radio" name="reviewScore" value="2">
							<span>2점 ⭐⭐</span>
						</label> <label> <input type="radio" name="reviewScore" value="1">
							<span>1점 ⭐</span>
						</label>

					</div>

				</div>

				<div class="form-group">
					<label>리뷰 내용</label>
					<textarea name="reviewContents" class="form-control" rows="4"
						required></textarea>
				</div>

				<button type="submit" class="btn btn-brown">리뷰 등록</button>

				</form>

				<div class="detail-btn-group">

					<c:if test="${member.memberNum eq dto.memberNum}">

						<a
							href="./update?restaurantNum=${dto.restaurantNum}&page=${param.page}&search=${param.search}"
							class="btn btn-brown"> 수정 </a>

						<form action="./delete" method="post" style="display: inline;"
							onsubmit="return confirm('맛집을 삭제하시겠습니까?');">

							<input type="hidden" name="restaurantNum"
								value="${dto.restaurantNum}"> <input type="hidden"
								name="page" value="${param.page}"> <input type="hidden"
								name="search" value="${param.search}">

							<button type="submit" class="btn btn-restaurant-delete">
								삭제</button>

						</form>

					</c:if>

					<c:choose>
						<c:when test="${not empty param.page or not empty param.search}">
							<a href="./list?page=${param.page}&search=${param.search}"
								class="btn btn-back">목록으로</a>
						</c:when>
						<c:otherwise>
							<a href="./list" class="btn btn-back">목록으로</a>
						</c:otherwise>
					</c:choose>

				</div>

			</div>

		</div>

	</div>

	<div id="imageModal" class="image-modal">
		<span class="image-modal-close">&times;</span> <img
			class="image-modal-content" id="modalImage">
	</div>

	<script>
		const restaurantNum = "${dto.restaurantNum}";
		const restaurantLocation = "${dto.restaurantLocation}";
		const restaurantDetailAddress = "${dto.restaurantDetailAddress}";
		const restaurantName = "${dto.restaurantName}";

		if (restaurantLocation && document.querySelector("#map")) {

			const mapContainer = document.querySelector("#map");

			const mapOption = {
				center : new kakao.maps.LatLng(37.566826, 126.9786567),
				level : 3
			};

			const map = new kakao.maps.Map(mapContainer, mapOption);
			const geocoder = new kakao.maps.services.Geocoder();

			geocoder
					.addressSearch(
							restaurantLocation,
							function(result, status) {

								console.log(restaurantLocation);
								console.log(status);
								console.log(result);

								if (status === kakao.maps.services.Status.OK) {

									const coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);

									const marker = new kakao.maps.Marker({
										map : map,
										position : coords
									});

									const infoWindow = new kakao.maps.InfoWindow(
											{
												content : '<div style="padding:8px;font-size:13px;font-weight:700;">'
														+ restaurantName
														+ '</div>'
											});

									infoWindow.open(map, marker);

									map.setCenter(coords);

									document.querySelector("#kakaoMapLink").href = "https://map.kakao.com/link/search/"
											+ encodeURIComponent(restaurantLocation);
								}
							});
		}

		function makeStars(score) {
			let stars = "";

			for (let i = 0; i < Number(score); i++) {
				stars += "⭐";
			}

			return stars;
		}

		function escapeHtml(text) {
			if (text == null) {
				return "";
			}

			return String(text).replaceAll("&", "&amp;")
					.replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\"", "&quot;").replaceAll("'", "&#039;");
		}

		function updateReviewSummary() {

			fetch("/restaurant/reviewSummary", {
				method : "POST",
				headers : {
					"Content-Type" : "application/x-www-form-urlencoded"
				},
				body : "restaurantNum=" + encodeURIComponent(restaurantNum)
			})
					.then(function(response) {
						return response.json();
					})
					.then(
							function(result) {

								if (!result.avgScore || result.avgScore === 0) {
									result.avgScore = 0;
								}

								const avgScoreText = Number(result.avgScore)
										.toFixed(1);

								document.querySelectorAll(".avg-score")
										.forEach(function(item) {
											item.innerText = avgScoreText;
										});

								document
										.querySelectorAll(".review-count")
										.forEach(
												function(item) {
													item.innerText = result.reviewCount;
												});

								const reviewMetaBadge = document
										.querySelector(".detail-meta-badge:nth-child(2)");

								if (reviewMetaBadge) {
									reviewMetaBadge.innerText = "📝 "
											+ result.reviewCount;
								}

							});
		}

		function restoreReviewCard(card, reviewNum, contents, score) {

			const contentsBox = card.querySelector(".review-contents");
			const scoreBox = card.querySelector(".review-score-text");
			const btnGroup = card.querySelector(".review-btn-group");

			contentsBox.innerText = contents;
			scoreBox.innerText = makeStars(score);

			btnGroup.innerHTML = '<button type="button" class="btn btn-sm btn-review-update" '
					+ 'data-review-num="'
					+ reviewNum
					+ '" '
					+ 'data-review-contents="'
					+ escapeHtml(contents)
					+ '" '
					+ 'data-review-score="'
					+ score
					+ '">'
					+ '수정</button> '
					+

					'<button type="button" class="btn btn-sm btn-review-delete" ' +
				'data-review-num="' + reviewNum + '">'
					+ '삭제</button>';
		}

		const likeBtn = document.querySelector("#likeBtn");

		if (likeBtn) {

			likeBtn.addEventListener("click", function() {

				fetch("./like", {
					method : "POST",
					headers : {
						"Content-Type" : "application/x-www-form-urlencoded"
					},
					body : new URLSearchParams({
						restaurantNum : restaurantNum
					})
				}).then(function(response) {
					return response.text();
				}).then(
						function(result) {

							result = result.trim();

							if (result === "login") {
								alert("로그인이 필요합니다.");
								location.href = "/member/login";
								return;
							}

							const likeCount = document
									.querySelector(".like-count");

							let countText = likeCount.innerText.replace("좋아요",
									"").trim();
							let count = Number(countText);

							if (result === "add") {
								likeBtn.innerText = "❤️ 좋아요 취소";
								likeCount.innerText = "좋아요 " + (count + 1);
								return;
							}

							if (result === "delete") {
								likeBtn.innerText = "🤍 좋아요";
								likeCount.innerText = "좋아요 "
										+ Math.max(count - 1, 0);
								return;
							}

						});

			});

		}

		const slider = document.querySelector(".detail-slider");
		const prevBtn = document.querySelector(".slider-prev");
		const nextBtn = document.querySelector(".slider-next");

		if (slider && prevBtn && nextBtn) {

			nextBtn.addEventListener("click", function() {
				slider.scrollBy({
					left : slider.clientWidth,
					behavior : "smooth"
				});
			});

			prevBtn.addEventListener("click", function() {
				slider.scrollBy({
					left : -slider.clientWidth,
					behavior : "smooth"
				});
			});

		}

		const reviewForm = document.querySelector("#reviewForm");

		if (reviewForm) {

			reviewForm
					.addEventListener(
							"submit",
							function(e) {

								e.preventDefault();

								const formData = new FormData(reviewForm);

								fetch("/restaurantReview/add", {
									method : "POST",
									body : formData
								})
										.then(function(response) {
											return response.json();
										})
										.then(
												function(review) {

													if (review == null
															|| review.reviewNum == null) {
														alert("로그인이 필요합니다.");
														location.href = "/member/login";
														return;
													}

													const reviewList = document
															.querySelector(".review-list");
													const emptyReview = document
															.querySelector(".empty-review");

													if (emptyReview) {
														emptyReview.remove();
													}

													const card = document
															.createElement("div");

													card.className = "review-card";
													card.id = "review-"
															+ review.reviewNum;

													card.innerHTML = '<div class="review-head">'
															+

															'<div>'
															+ '<strong>'
															+ escapeHtml(review.memberName)
															+ '</strong> '
															+ '<span class="review-date">방금 전</span>'
															+ '</div>'
															+

															'<div class="review-score-text">'
															+ makeStars(review.reviewScore)
															+ '</div>'
															+

															'</div>'
															+

															'<div class="review-contents">'
															+ escapeHtml(review.reviewContents)
															+ '</div>'
															+

															'<div class="review-btn-group">'
															+

															'<button type="button" class="btn btn-sm btn-review-update" '
															+ 'data-review-num="'
															+ review.reviewNum
															+ '" '
															+ 'data-review-contents="'
															+ escapeHtml(review.reviewContents)
															+ '" '
															+ 'data-review-score="'
															+ review.reviewScore
															+ '">'
															+ '수정'
															+ '</button> '
															+

															'<button type="button" class="btn btn-sm btn-review-delete" ' +
								'data-review-num="' + review.reviewNum + '">'
															+ '삭제'
															+ '</button>' +

															'</div>';

													reviewList.prepend(card);

													reviewForm.reset();

													const checked = reviewForm
															.querySelector("input[name='reviewScore'][value='5']");

													if (checked) {
														checked.checked = true;
													}

													updateReviewSummary();
													alert("리뷰가 등록되었습니다.");

												});

							});

		}

		const reviewList = document.querySelector(".review-list");
		const reviewSortBtns = document.querySelectorAll(".review-sort-btn");

		reviewSortBtns.forEach(function(btn) {

			btn.addEventListener("click", function() {

				reviewSortBtns.forEach(function(item) {
					item.classList.remove("active");
				});

				btn.classList.add("active");

				const sortType = btn.dataset.sort;
				sortReviews(sortType);

			});

		});

		function sortReviews(sortType) {

			const reviewList = document.querySelector(".review-list");

			if (!reviewList) {
				return;
			}

			const cards = Array.from(reviewList
					.querySelectorAll(".review-card"));

			cards.sort(function(a, b) {

				if (sortType === "high") {
					return Number(b.dataset.score) - Number(a.dataset.score);
				}

				if (sortType === "low") {
					return Number(a.dataset.score) - Number(b.dataset.score);
				}

				return Number(b.dataset.num) - Number(a.dataset.num);
			});

			cards.forEach(function(card) {
				reviewList.appendChild(card);
			});
		}

		if (reviewList) {

			reviewList
					.addEventListener(
							"click",
							function(e) {

								if (e.target.classList
										.contains("btn-review-delete")) {

									if (!confirm("리뷰를 삭제하시겠습니까?")) {
										return;
									}

									const reviewNum = e.target.dataset.reviewNum;
									const card = document
											.querySelector("#review-"
													+ reviewNum);

									fetch(
											"/restaurantReview/delete",
											{
												method : "POST",
												headers : {
													"Content-Type" : "application/x-www-form-urlencoded"
												},
												body : "reviewNum="
														+ encodeURIComponent(reviewNum)
											})
											.then(function(response) {
												return response.text();
											})
											.then(
													function(result) {

														result = result.trim();

														if (result === "login") {
															alert("로그인이 필요합니다.");
															location.href = "/member/login";
															return;
														}

														if (result === "1") {
															card.remove();
															updateReviewSummary();

															if (document
																	.querySelectorAll(".review-card").length === 0) {
																reviewList.innerHTML = '<div class="empty-review">아직 등록된 리뷰가 없습니다.</div>';
															}

															alert("리뷰가 삭제되었습니다.");

															return;
														}

														alert("삭제 권한이 없거나 삭제에 실패했습니다.");

													});

								}

								if (e.target.classList
										.contains("btn-review-update")) {

									const reviewNum = e.target.dataset.reviewNum;
									const reviewContents = e.target.dataset.reviewContents;
									const reviewScore = e.target.dataset.reviewScore;

									const card = document
											.querySelector("#review-"
													+ reviewNum);
									const contentsBox = card
											.querySelector(".review-contents");
									const btnGroup = card
											.querySelector(".review-btn-group");

									contentsBox.innerHTML = '<div class="form-group">'
											+ '<label>평점</label>'
											+ '<select class="form-control update-review-score">'
											+ '<option value="5">⭐⭐⭐⭐⭐</option>'
											+ '<option value="4">⭐⭐⭐⭐</option>'
											+ '<option value="3">⭐⭐⭐</option>'
											+ '<option value="2">⭐⭐</option>'
											+ '<option value="1">⭐</option>'
											+ '</select>'
											+ '</div>'
											+

											'<div class="form-group">'
											+ '<label>리뷰 내용</label>'
											+ '<textarea class="form-control update-review-contents" rows="4"></textarea>'
											+ '</div>';

									card.querySelector(".update-review-score").value = reviewScore;
									card
											.querySelector(".update-review-contents").value = reviewContents;

									btnGroup.innerHTML = '<button type="button" class="btn btn-sm btn-brown btn-review-save" ' +
							'data-review-num="' + reviewNum + '">'
											+ '저장'
											+ '</button> '
											+

											'<button type="button" class="btn btn-sm btn-back btn-review-cancel" '
											+ 'data-review-num="'
											+ reviewNum
											+ '" '
											+ 'data-review-contents="'
											+ escapeHtml(reviewContents)
											+ '" '
											+ 'data-review-score="'
											+ reviewScore
											+ '">'
											+ '취소'
											+ '</button>';

								}

								if (e.target.classList
										.contains("btn-review-cancel")) {

									const reviewNum = e.target.dataset.reviewNum;
									const reviewContents = e.target.dataset.reviewContents;
									const reviewScore = e.target.dataset.reviewScore;

									const card = document
											.querySelector("#review-"
													+ reviewNum);

									restoreReviewCard(card, reviewNum,
											reviewContents, reviewScore);

								}

								if (e.target.classList
										.contains("btn-review-save")) {

									const reviewNum = e.target.dataset.reviewNum;
									const card = document
											.querySelector("#review-"
													+ reviewNum);

									const newScore = card
											.querySelector(".update-review-score").value;
									const newContents = card
											.querySelector(".update-review-contents").value;

									fetch(
											"/restaurantReview/update",
											{
												method : "POST",
												headers : {
													"Content-Type" : "application/x-www-form-urlencoded"
												},
												body : new URLSearchParams(
														{
															reviewNum : reviewNum,
															reviewScore : newScore,
															reviewContents : newContents
														})
											})
											.then(function(response) {
												return response.text();
											})
											.then(
													function(result) {

														result = result.trim();

														if (result === "login") {
															alert("로그인이 필요합니다.");
															location.href = "/member/login";
															return;
														}

														if (result === "1") {
															restoreReviewCard(
																	card,
																	reviewNum,
																	newContents,
																	newScore);

															updateReviewSummary();

															alert("리뷰가 수정되었습니다.");

															return;
														}

														alert("수정 권한이 없거나 수정에 실패했습니다.");

													});

								}

							});

		}

		const detailImages = document
				.querySelectorAll(".restaurant-detail-img");
		const imageModal = document.querySelector("#imageModal");
		const modalImage = document.querySelector("#modalImage");
		const imageModalClose = document.querySelector(".image-modal-close");

		detailImages.forEach(function(img) {
			img.addEventListener("click", function() {
				imageModal.style.display = "flex";
				modalImage.src = this.src;
			});
		});

		imageModalClose.addEventListener("click", function() {
			imageModal.style.display = "none";
		});

		imageModal.addEventListener("click", function(e) {
			if (e.target === imageModal) {
				imageModal.style.display = "none";
			}
		});
	</script>



</body>
</html>