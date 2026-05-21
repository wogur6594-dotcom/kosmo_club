<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛집 등록</title>

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

			<h1 class="form-title">맛집 등록</h1>

			<form action="./create" method="post" enctype="multipart/form-data">

				<div class="form-group">

					<label>맛집 이름</label> <input type="text" name="restaurantName"
						class="form-control" required>

				</div>
				<div class="detail-score">⭐ 평점 ${dto.avgScore} / 리뷰
					${dto.reviewCount}개</div>
				<div class="form-group">

					<label>카테고리</label> <select name="restaurantCategory"
						class="form-control">

						<option value="한식">한식</option>
						<option value="중식">중식</option>
						<option value="일식">일식</option>
						<option value="양식">양식</option>
						<option value="카페">카페</option>
						<option value="치킨">치킨</option>
						<option value="분식">분식</option>

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
						class="form-control">

				</div>

				<div class="form-group">

					<label>영업시간</label> <input type="text" name="restaurantTime"
						class="form-control">

				</div>

				<div class="form-group">

					<label>평점</label> <input type="number" step="0.1" min="0" max="5"
						name="restaurantScore" class="form-control">

				</div>

				<div class="form-group">

					<label>설명</label>

					<textarea name="restaurantContents" rows="6" class="form-control"></textarea>

				</div>

				<div class="form-group">

					<label>사진 등록</label> <input type="file" name="files"
						class="form-control-file" multiple>

				</div>

				<div class="form-btn-group">

					<button class="btn btn-brown">등록하기</button>

					<a href="./list" class="btn btn-back"> 뒤로가기 </a>

				</div>

			</form>

		</div>

	</div>

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