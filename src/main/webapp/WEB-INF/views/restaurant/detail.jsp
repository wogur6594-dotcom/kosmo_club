<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${dto.restaurantName}</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/restaurant.css">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=여기에_JavaScript키&libraries=services"></script>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="restaurant-detail-wrap">

		<div class="restaurant-detail-box">

			<c:choose>
				<c:when test="${not empty dto.fileDTOs}">

					<div class="detail-slider-wrap">

						<button type="button" class="slider-btn slider-prev">‹</button>

						<div class="detail-slider">

							<c:forEach items="${dto.fileDTOs}" var="file">
								<div class="detail-slide-item">
									<img src="/files/restaurant/${file.fileName}"
										class="restaurant-detail-img">
								</div>
							</c:forEach>

						</div>

						<button type="button" class="slider-btn slider-next">›</button>

					</div>

				</c:when>

				<c:otherwise>
					<div class="detail-no-image">등록된 사진이 없습니다.</div>
				</c:otherwise>
			</c:choose>

			<div class="detail-body">

				<div class="detail-top">
					<h1 class="detail-title">${dto.restaurantName}</h1>
					<div class="detail-category">${dto.restaurantCategory}</div>
				</div>

				<div class="detail-info">

					<div class="detail-item">📍 ${dto.restaurantLocation}
						${dto.restaurantDetailAddress}</div>
					<div class="detail-item">📞 ${dto.restaurantPhone}</div>
					<div class="detail-item">🕒 ${dto.restaurantTime}</div>

					<div class="detail-item review-summary">
						⭐ <span class="avg-score"> <fmt:formatNumber
								value="${dto.avgScore}" pattern="0.0" />
						</span> / 리뷰 <span class="review-count">${dto.reviewCount}</span>개
					</div>

					<div class="detail-item">작성자 : ${dto.memberName}</div>
					<div class="detail-item">👀 조회수 ${dto.hit}</div>

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

					<form id="reviewForm" action="/restaurantReview/add" method="post"
						class="review-form">

						<input type="hidden" name="restaurantNum"
							value="${dto.restaurantNum}">

						<div class="form-group">

							<label>평점</label>

							<div class="star-select">

								<label> <input type="radio" name="reviewScore" value="5"
									checked> <span>⭐⭐⭐⭐⭐</span>
								</label> <label> <input type="radio" name="reviewScore"
									value="4"> <span>⭐⭐⭐⭐</span>
								</label> <label> <input type="radio" name="reviewScore"
									value="3"> <span>⭐⭐⭐</span>
								</label> <label> <input type="radio" name="reviewScore"
									value="2"> <span>⭐⭐</span>
								</label> <label> <input type="radio" name="reviewScore"
									value="1"> <span>⭐</span>
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

					<div class="review-list">

						<c:forEach items="${reviewList}" var="review">

							<div class="review-card" id="review-${review.reviewNum}">

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

				<div class="detail-btn-group">

					<c:if test="${member.memberNum eq dto.memberNum}">

						<a href="./update?restaurantNum=${dto.restaurantNum}"
							class="btn btn-brown"> 수정 </a>

						<form action="./delete" method="post" style="display: inline;"
							onsubmit="return confirm('맛집을 삭제하시겠습니까?');">

							<input type="hidden" name="restaurantNum"
								value="${dto.restaurantNum}">

							<button type="submit" class="btn btn-restaurant-delete">
								삭제</button>

						</form>

					</c:if>

					<a href="./list" class="btn btn-back">목록으로</a>

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
		const restaurantLocation = "${dto.restaurantLocation} ${dto.restaurantDetailAddress}";
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

								document.querySelector(".avg-score").innerText = Number(
										result.avgScore).toFixed(1);

								document.querySelector(".review-count").innerText = result.reviewCount;

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
				}).then(function(result) {

					result = result.trim();

					if (result === "login") {
						alert("로그인이 필요합니다.");
						location.href = "/member/login";
						return;
					}

					location.reload();

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

												});

							});

		}

		const reviewList = document.querySelector(".review-list");

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