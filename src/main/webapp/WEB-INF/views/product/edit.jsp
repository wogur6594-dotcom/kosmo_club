<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>상품 수정</title>
</head>

<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container mt-5">
		<div class="row">
			<div class="col-md-6">
				<c:choose>
					<c:when test="${not empty product.fileList}">
						<div id="productCarousel" class="carousel slide" data-ride="carousel">
							<div class="carousel-inner">
								<c:forEach var="f" items="${product.fileList}" varStatus="status">
									<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
										<img src="/files/product/${f.fileName}" class="d-block w-100" style="height: 400px; object-fit: cover;">
									</div>
								</c:forEach>
							</div>
							<a class="carousel-control-prev" href="#productCarousel" data-slide="prev">
								<span class="carousel-control-prev-icon"></span>
							</a>
							<a class="carousel-control-next" href="#productCarousel" data-slide="next">
								<span class="carousel-control-next-icon"></span>
							</a>
						</div>
						<div class="mt-3 d-flex flex-wrap" id="fileBox">
							<c:forEach var="f" items="${product.fileList}">
								<div class="position-relative mr-2 file-box">
									<img src="/files/product/${f.fileName}" style="width: 80px; height: 80px; object-fit: cover;">
									<button type="button" class="btn btn-sm btn-danger delete-btn" data-file-num="${f.fileNum}" style="position: absolute; top: 0; right: 0;">
										<i class="bi bi-x"></i>
									</button>
								</div>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<img src="/image/noImage.png" class="img-fluid">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="col-md-6">

				<form action="/product/edit" method="post" enctype="multipart/form-data">

					<input type="hidden" name="productNum" value="${product.productNum}">
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">상품명</span>
						</div>
						<input type="text" class="form-control" name="productTitle" value="${product.productTitle}">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">가격</span>
						</div>
						<input type="number" class="form-control" name="productPrice" value="${product.productPrice}">
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">지역</span>
						</div>
						<select class="form-control" name="productLocation">
							<option value="서울시 구로구" ${product.productLocation == '서울시 구로구' ? 'selected' : ''}>서울시 구로구</option>
							<option value="서울시 금천구" ${product.productLocation == '서울시 금천구' ? 'selected' : ''}>서울시 금천구</option>
							<option value="서울시 양천구" ${product.productLocation == '서울시 양천구' ? 'selected' : ''}>서울시 양천구</option>
							<option value="서울시 영등포구" ${product.productLocation == '서울시 영등포구' ? 'selected' : ''}>서울시 영등포구</option>
						</select>
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">상품종류</span>
						</div>
						<select class="form-control" name="productType">
							<option value="디지털기기" ${product.productType == '디지털기기' ? 'selected' : ''}>디지털기기</option>
							<option value="생활가전" ${product.productType == '생활가전' ? 'selected' : ''}>생활가전</option>
							<option value="가구/인테리어" ${product.productType == '가구/인테리어' ? 'selected' : ''}>가구/인테리어</option>
							<option value="생활/주방" ${product.productType == '생활/주방' ? 'selected' : ''}>생활/주방</option>
							<option value="유아물품" ${product.productType == '유아물품' ? 'selected' : ''}>유아물품</option>
							<option value="의류" ${product.productType == '의류' ? 'selected' : ''}>의류</option>
							<option value="잡화" ${product.productType == '잡화' ? 'selected' : ''}>잡화</option>
							<option value="뷰티/미용" ${product.productType == '뷰티/미용' ? 'selected' : ''}>뷰티/미용</option>
							<option value="스포츠/레저" ${product.productType == '스포츠/레저' ? 'selected' : ''}>스포츠/레저</option>
							<option value="취미/게임/음반" ${product.productType == '취미/게임/음반' ? 'selected' : ''}>취미/게임/음반</option>
							<option value="티켓/e쿠폰" ${product.productType == '티켓/e쿠폰' ? 'selected' : ''}>티켓/e쿠폰</option>
							<option value="식품" ${product.productType == '식품' ? 'selected' : ''}>식품</option>
							<option value="기타" ${product.productType == '기타' ? 'selected' : ''}>기타</option>
						</select>
					</div>
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">판매상태</span>
						</div>
						<select class="form-control" name="productStatus">
							<option>판매중</option>
							<option value="거래중">거래중</option>
							<option value="판매완료">판매완료</option>
						</select>
					</div>
					<div class="form-group">
						<label>상품 설명</label>
						<textarea class="form-control" name="productContent" rows="7">${product.productContent}</textarea>
					</div>
					<input type="hidden" name="productNum" value="${product.productNum}">
					<label>이미지 바로 추가</label>
					<div class="form-group">
						<input type="hidden" id="productNum" value="${product.productNum}">
						<input type="file" id="fileInput" name="file" multiple>
						<button type="button" id="addFileBtn" class="btn btn-primary">이미지 추가</button>
					</div>
					<div id="previewBox" class="d-flex flex-wrap mt-2"></div>
					<button type="submit" class="btn btn-success">수정 완료</button>
					<a href="/product/detail?productNum=${product.productNum}" class="btn btn-secondary">취소</a>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/product/edit.js"></script>
</body>
</html>