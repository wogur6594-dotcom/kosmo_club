<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>상품 수정</title>

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
			<h2 class="add-title">상품 정보 수정</h2>
			<p class="add-desc">등록한 상품 정보를 수정할 수 있습니다.</p>
		</div>

		<div class="form-group">
			<label>현재 등록된 이미지</label>

			<c:choose>
				<c:when test="${not empty product.fileList}">
					<div class="current-file-box" id="fileBox">
						<c:forEach var="f" items="${product.fileList}">
							<div class="current-img-box file-box">
								<c:choose>
									<c:when test="${fn:startsWith(f.fileName, 'http')}">
										<img src="${f.fileName}" alt="상품 이미지">
									</c:when>
									<c:otherwise>
										<img src="/files/product/${f.fileName}" alt="상품 이미지">
									</c:otherwise>
								</c:choose>

								<button type="button" class="current-img-delete delete-btn"
									data-file-num="${f.fileNum}">
									<i class="bi bi-x"></i>
								</button>
							</div>
						</c:forEach>
					</div>
				</c:when>

				<c:otherwise>
					<div class="empty-image-text">등록된 이미지가 없습니다.</div>
				</c:otherwise>
			</c:choose>
		</div>

		<form:form action="/product/edit" method="post"
			modelAttribute="productDTO" enctype="multipart/form-data">

			<form:hidden path="productNum" />

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
						<button type="button" class="btn btn-check"
							onclick="searchAddress()">주소 검색</button>
					</div>
				</div>
				<form:errors path="productLocation" cssClass="error-msg" />
			</div>

			<div class="form-row">
				<div class="form-group col-md-6">
					<label>카테고리</label>
					<form:select path="productType" class="form-control">
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

				<div class="form-group col-md-6">
					<label>판매상태</label>
					<form:select path="productStatus" class="form-control">
						<form:option value="판매중">판매중</form:option>
						<form:option value="거래중">거래중</form:option>
						<form:option value="판매완료">판매완료</form:option>
					</form:select>
				</div>
			</div>

			<div class="form-group">
				<label>상품 설명</label>
				<form:textarea path="productContent" class="form-control" rows="8"
					placeholder="설명을 입력해주세요" />
				<form:errors path="productContent" cssClass="error-msg" />
			</div>

			<div class="form-group">
				<label>이미지 추가</label>

				<div class="custom-file">
					<input type="file" id="fileInput" name="file"
						class="custom-file-input" multiple accept="image/*"> <label
						class="custom-file-label" for="fileInput"> 사진을 선택해 주세요 </label>
				</div>

				<div class="edit-image-action">
					<button type="button" id="addFileBtn"
						class="btn btn-outline-orange">선택한 이미지 추가</button>
				</div>

				<div id="previewBox" class="preview-box"></div>
			</div>

			<div class="add-btn-box">
				<a href="/product/detail?productNum=${product.productNum}"
					class="btn btn-outline-orange">취소</a>

				<button type="submit" class="btn btn-orange">수정 완료</button>
			</div>

		</form:form>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/product/edit.js"></script>

</body>
</html>