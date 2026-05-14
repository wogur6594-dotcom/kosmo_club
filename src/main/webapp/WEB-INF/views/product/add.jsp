<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>상품 등록</title>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	<div class="container mt-5">
		<h1 class="mb-4">상품 등록</h1>
		<form action="./add" method="post" enctype="multipart/form-data">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">상품명</span>
				</div>
				<input type="text" class="form-control" name="productTitle" placeholder="상품명을 입력하세요">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">가격</span>
				</div>
				<input type="number" class="form-control" name="productPrice" placeholder="가격 입력">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">지역</span>
				</div>
				<select class="form-control" name="productLocation">
					<option value="">지역 선택</option>
					<option value="서울시 구로구">서울시 구로구</option>
					<option value="서울시 금천구">서울시 금천구</option>
					<option value="서울시 양천구">서울시 양천구</option>
					<option value="서울시 영등포구">서울시 영등포구</option>
				</select>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">상품종류</span>
				</div>
				<select class="form-control" name="productType">
					<option value="기타">선택</option>
					<option value="디지털기기">디지털기기</option>
					<option value="생활가전">생활가전</option>
					<option value="가구/인테리어">가구/인테리어</option>
					<option value="생활/주방">생활/주방</option>
					<option value="유아물품">유아물품</option>
					<option value="의류">의류</option>
					<option value="잡화">잡화</option>
					<option value="뷰티/미용">뷰티/미용</option>
					<option value="스포츠/레저">스포츠/레저</option>
					<option value="취미/게임/음반">취미/게임/음반</option>
					<option value="티켓/e쿠폰">티켓/e쿠폰</option>
					<option value="식품">식품</option>
					<option value="기타">기타</option>
				</select>
			</div>
			<div class="form-group">
				<label>상품 설명</label>
				<textarea class="form-control" name="productContent" rows="7" placeholder="상품 설명을 입력하세요"></textarea>
			</div>
			<div>
				<input type="file" name="attachs" multiple>
				<button type="submit">등록</button>
			</div>
			<button type="submit" class="btn btn-outline-dark">등록하기</button>
		</form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>