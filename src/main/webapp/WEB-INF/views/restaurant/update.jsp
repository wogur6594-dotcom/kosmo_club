<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 수정</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/restaurant.css">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="restaurant-form-wrap">

		<div class="restaurant-form-box">

			<h1 class="form-title">맛집 수정</h1>

			<form id="updateForm" action="./update" method="post"
				enctype="multipart/form-data">

				<input type="hidden" name="restaurantNum"
					value="${dto.restaurantNum}">

				<div class="form-group">
					<label>맛집 이름</label> <input type="text" name="restaurantName"
						class="form-control" required value="${dto.restaurantName}">
				</div>

				<div class="detail-score">
					⭐ 평점
					<fmt:formatNumber value="${dto.avgScore}" pattern="0.0" />
					/ 리뷰 ${dto.reviewCount}개
				</div>

				<div class="form-group">
					<label>카테고리</label> <select name="restaurantCategory"
						class="form-control">

						<option value="한식"
							<c:if test="${dto.restaurantCategory eq '한식'}">selected</c:if>>
							한식</option>

						<option value="중식"
							<c:if test="${dto.restaurantCategory eq '중식'}">selected</c:if>>
							중식</option>

						<option value="일식"
							<c:if test="${dto.restaurantCategory eq '일식'}">selected</c:if>>
							일식</option>

						<option value="양식"
							<c:if test="${dto.restaurantCategory eq '양식'}">selected</c:if>>
							양식</option>

						<option value="카페"
							<c:if test="${dto.restaurantCategory eq '카페'}">selected</c:if>>
							카페</option>

						<option value="치킨"
							<c:if test="${dto.restaurantCategory eq '치킨'}">selected</c:if>>
							치킨</option>

						<option value="분식"
							<c:if test="${dto.restaurantCategory eq '분식'}">selected</c:if>>
							분식</option>

					</select>
				</div>

				<div class="form-group">
					<label>주소</label>

					<div class="address-row">
						<input type="text" id="restaurantLocation"
							name="restaurantLocation" class="form-control" readonly required
							value="${dto.restaurantLocation}">

						<button type="button" class="btn btn-brown"
							onclick="searchAddress()">주소 검색</button>
					</div>
				</div>

				<div class="form-group">
					<label>상세주소</label> <input type="text" id="restaurantDetailAddress"
						name="restaurantDetailAddress" class="form-control"
						placeholder="예: 2층, 201호, 가게 안쪽 등"
						value="${dto.restaurantDetailAddress}">
				</div>

				<div class="form-group">
					<label>전화번호</label> <input type="text" name="restaurantPhone"
						class="form-control" value="${dto.restaurantPhone}">
				</div>

				<div class="form-group">
					<label>영업시간</label> <input type="text" name="restaurantTime"
						class="form-control" value="${dto.restaurantTime}">
				</div>

				<div class="form-group">
					<label>설명</label>
					<textarea name="restaurantContents" rows="6" class="form-control">${dto.restaurantContents}</textarea>
				</div>

				<div class="form-group">
					<label>현재 등록된 사진</label>

					<div class="update-file-list">

						<c:choose>
							<c:when test="${not empty dto.fileDTOs}">

								<c:forEach items="${dto.fileDTOs}" var="file">

									<div class="update-file-card">

										<img src="/files/restaurant/${file.fileName}">

										<button type="button" class="file-delete-btn"
											data-file-num="${file.fileNum}">×</button>

										<div class="update-file-name">${file.oriName}</div>

									</div>

								</c:forEach>

							</c:when>

							<c:otherwise>
								<div class="empty-review">등록된 사진이 없습니다.</div>
							</c:otherwise>
						</c:choose>

					</div>
				</div>

				<div class="form-group">
					<label>새 사진 추가</label> <input type="file" name="files"
						class="form-control-file" multiple>
				</div>

				<div class="form-btn-group">
					<button type="submit" class="btn btn-brown">수정하기</button>

					<a href="./detail?restaurantNum=${dto.restaurantNum}"
						class="btn btn-back"> 뒤로가기 </a>
				</div>

			</form>

		</div>

	</div>

	<script>
		const deleteButtons = document.querySelectorAll(".file-delete-btn");
		const updateForm = document.querySelector("#updateForm");

		deleteButtons
				.forEach(function(btn) {
					btn
							.addEventListener(
									"click",
									function() {

										const fileNum = this.dataset.fileNum;
										const card = this
												.closest(".update-file-card");

										const input = document
												.createElement("input");
										input.type = "hidden";
										input.name = "deleteFileNums";
										input.value = fileNum;

										updateForm.appendChild(input);
										card.remove();

										const fileList = document
												.querySelector(".update-file-list");

										if (document
												.querySelectorAll(".update-file-card").length === 0) {
											fileList.innerHTML = '<div class="empty-review">등록된 사진이 없습니다.</div>';
										}
									});
				});
	</script>

	<script>
		function searchAddress() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							let address = "";

							if (data.userSelectedType === "R") {
								address = data.roadAddress;
							} else {
								address = data.jibunAddress;
							}

							document.querySelector("#restaurantLocation").value = address;
							document.querySelector("#restaurantDetailAddress")
									.focus();
						}
					}).open();
		}
	</script>

</body>
</html>