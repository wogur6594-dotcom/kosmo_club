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

				<form:form action="/product/edit" method="post" modelAttribute="productDTO" enctype="multipart/form-data">

					<form:hidden path="productNum" />
					<form:errors path="productTitle" cssStyle="color:red" />
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">상품명</span>
						</div>
						<form:input path="productTitle" class="form-control" placeholder="상품명을 입력하세요" />
					</div>
					
					<form:errors path="productPrice" cssStyle="color:red" />
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">가격</span>
						</div>
						<form:input path="productPrice" type="number" class="form-control" placeholder="가격 입력" />
					</div>
					
					<form:errors path="productLocation" cssStyle="color:red" />
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">지역</span>
						</div>
						<form:input path="productLocation" id="productLocation" class="form-control" readonly="true" />
						<div class="input-group-append">
							<button type="button" class="btn btn-outline-secondary" onclick="searchAddress()">주소 검색</button>
						</div>
					</div>
					
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">상품종류</span>
						</div>
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
					
					<div class="input-group mb-3">
						<div class="input-group-prepend">
							<span class="input-group-text">판매상태</span>
						</div>
						<form:select path="productStatus" class="form-control">
							<form:option value="판매중">판매중</form:option>
							<form:option value="거래중">거래중</form:option>
							<form:option value="판매완료">판매완료</form:option>
						</form:select>
					</div>
					
					<form:errors path="productContent" cssStyle="color:red" />
					<div class="form-group">
						<label>상품 설명</label>
						<form:textarea path="productContent" class="form-control" rows="7" />
					</div>
					
					<label>이미지 바로 추가</label>
					<div class="form-group">
						<input type="hidden" id="productNum" value="${product.productNum}">
						<input type="file" id="fileInput" name="file" multiple>
						<button type="button" id="addFileBtn" class="btn btn-primary">이미지 추가</button>
					</div>
					<div id="previewBox" class="d-flex flex-wrap mt-2"></div>
					<button type="submit" class="btn btn-success">수정 완료</button>
					<a href="/product/detail?productNum=${product.productNum}" class="btn btn-secondary">취소</a>
				</form:form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/product/edit.js"></script>
</body>
</html>