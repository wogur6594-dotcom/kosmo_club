<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>상품 등록 - 당근 느낌</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-light-orange: #fff1eb;
    }
    body {
        background-color: #f8f9fa;
    }
    .add-container {
        max-width: 600px;
        margin: 60px auto;
        padding: 40px;
        background: white;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    .add-title {
        font-weight: bold;
        font-size: 24px;
        margin-bottom: 30px;
        text-align: center;
    }
    .form-group label {
        font-weight: bold;
        color: #495057;
        font-size: 14px;
        margin-bottom: 8px;
    }
    .form-control {
        border-radius: 8px;
        padding: 10px 15px;
        border: 1px solid #dee2e6;
        height: auto;
    }
    .form-control:focus {
        border-color: var(--daangn-orange);
        box-shadow: 0 0 0 0.2rem rgba(255, 138, 61, 0.2);
    }
    .btn-orange {
        background-color: var(--daangn-orange);
        color: white;
        border: none;
        font-weight: bold;
        padding: 12px;
        border-radius: 8px;
    }
    .btn-orange:hover {
        background-color: #e67831;
        color: white;
    }
    .btn-check {
        background-color: #e9ecef;
        border: none;
        color: #495057;
        font-size: 13px;
        border-radius: 6px;
        padding: 0 15px;
    }
    .error-msg {
        color: #fa5252;
        font-size: 12px;
        margin-top: 4px;
        display: block;
    }
    #previewBox img {
        width: 100px;
        height: 100px;
        object-fit: cover;
        border-radius: 8px;
        margin-right: 10px;
        margin-bottom: 10px;
        border: 1px solid #eee;
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="container add-container">
		<h2 class="add-title">내 물건 팔기</h2>
		
		<form:form action="./add" method="post" modelAttribute="productDTO" enctype="multipart/form-data">
			<div class="form-group mb-4">
                <label>상품명</label>
				<input type="text" class="form-control" name="productTitle" placeholder="상품명을 입력하세요">
                <form:errors path="productTitle" cssClass="error-msg" />
			</div>

			<div class="form-group mb-4">
                <label>가격 (원)</label>
				<input type="number" class="form-control" name="productPrice" placeholder="가격을 입력해주세요">
                <form:errors path="productPrice" cssClass="error-msg" />
			</div>

			<div class="form-group mb-4">
                <label>거래 지역</label>
				<div class="input-group">
                    <input type="text" id="productLocation" name="productLocation" class="form-control" readonly placeholder="주소 검색을 눌러주세요">
                    <div class="input-group-append">
                        <button class="btn btn-check" type="button" onclick="searchAddress()">주소 검색</button>
                    </div>
                </div>
                <form:errors path="productLocation" cssClass="error-msg" />
			</div>

			<div class="form-group mb-4">
                <label>카테고리</label>
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

			<div class="form-group mb-4">
				<label>상품 설명</label>
				<textarea class="form-control" name="productContent" rows="8" placeholder="게시글 내용을 작성해주세요. (판매 금지 물품은 게시가 제한될 수 있어요.)"></textarea>
                <form:errors path="productContent" cssClass="error-msg" />
			</div>

			<div class="form-group mb-4">
                <label>상품 이미지</label>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" name="attachs" id="fileInput" multiple accept="image/*">
                    <label class="custom-file-label" for="fileInput">사진을 선택해 주세요 (최대 10장)</label>
                </div>
                <form:errors path="attachs" cssClass="error-msg" />
			</div>
			
			<div id="previewBox" class="mt-3 d-flex flex-wrap"></div>
			
			<button type="submit" class="btn btn-orange btn-block mt-5 py-3">작성 완료</button>
		</form:form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/product/add.js"></script>
</body>
</html>