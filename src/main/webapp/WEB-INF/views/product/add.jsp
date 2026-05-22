<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>상품 등록</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="/css/product.css">
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container add-container">

		<div class="add-head">
			<p class="add-subtitle">중고거래</p>
			<h2 class="add-title">내 물건 팔기</h2>
			<p class="add-desc">상품 정보를 자세히 입력하면 거래 가능성이 높아집니다.</p>
		</div>

		<form:form action="./add" method="post" modelAttribute="productDTO"
			enctype="multipart/form-data">

			<div class="form-group">
				<label>상품명</label>
				<form:input path="productTitle" class="form-control"
					placeholder="상품명을 입력하세요" />
				<form:errors path="productTitle" cssClass="error-msg" />
			</div>

			<div class="form-group">
				<label>가격</label>
				<form:input path="productPrice" type="number" class="form-control"
					placeholder="가격을 입력해주세요" />
				<form:errors path="productPrice" cssClass="error-msg" />
			</div>

			<div class="form-group">
				<label>거래 지역</label>
				<div class="input-group">
					<form:input path="productLocation" id="productLocation"
						class="form-control" readonly="true" placeholder="주소 검색을 눌러주세요" />
					<div class="input-group-append">
						<button class="btn btn-check" type="button"
							onclick="searchAddress()">주소 검색</button>
					</div>
				</div>
				<form:errors path="productLocation" cssClass="error-msg" />
			</div>

			<div class="form-group">
				<label>카테고리</label>
				<form:select path="productType" class="form-control">
					<form:option value="기타">선택</form:option>
					<form:option value="디지털기기">디지털기기</form:option>
					<form:option value="생활가전">생활가전</form:option>
					<form:option value="가구/인테리어">가구/인테리어</form:option>
					<form:option value="생활/주방">생활/주방</form:option>
					<form:option value="유아물품">유아물품</form:option>
					<form:option value="의류">의류</form:option>
					<form:option value="잡화">잡화</form:option>
					<form:option value="뷰티/미용">뷰티/미용</form:option>
					<form:option value="스포츠/레저">스포츠/레저</form:option>
					<form:option value="취미/게임/음반">취미/게임/음반</form:option>
					<form:option value="티켓/e쿠폰">티켓/e쿠폰</form:option>
					<form:option value="식품">식품</form:option>
					<form:option value="기타">기타</form:option>
				</form:select>
			</div>

			<div class="form-group">
				<label>상품 설명</label>
				<form:textarea path="productContent" class="form-control" rows="8"
					placeholder="구매 시기, 사용감, 하자 여부 등을 자세히 적어주세요." />
				<form:errors path="productContent" cssClass="error-msg" />
			</div>

			<div class="form-group">
				<label>상품 이미지</label>

				<div class="custom-file">
					<input type="file" class="custom-file-input" name="attachs"
						id="fileInput" multiple accept="image/*"> <label
						class="custom-file-label" for="fileInput"> 사진을 선택해 주세요 </label>
				</div>

				<form:errors path="attachs" cssClass="error-msg" />

				<div id="previewBox" class="preview-box"></div>
			</div>

			<div class="add-btn-box">
				<a href="./list" class="btn btn-outline-orange">취소</a>
				<button type="submit" class="btn btn-orange">작성 완료</button>
			</div>

		</form:form>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/product/add.js"></script>

</body>
</html>