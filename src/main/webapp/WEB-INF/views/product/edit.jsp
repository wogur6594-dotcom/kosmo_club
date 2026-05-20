<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>상품 수정 - 당근 느낌</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-light-orange: #fff1eb;
        --daangn-grey: #868e96;
    }
    body {
        background-color: #f8f9fa;
    }
    .edit-container {
        max-width: 800px;
        margin: 60px auto;
        background: white;
        border-radius: 16px;
        padding: 40px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    .edit-title {
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
    .current-img-box {
        position: relative;
        margin-right: 10px;
        margin-bottom: 10px;
    }
    .current-img-box img {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #eee;
    }
    .delete-btn {
        position: absolute;
        top: -5px;
        right: -5px;
        padding: 0;
        width: 20px;
        height: 20px;
        line-height: 20px;
        border-radius: 50%;
        font-size: 12px;
    }
</style>
</head>

<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container edit-container">
		<h2 class="edit-title">상품 정보 수정</h2>
        
		<div class="row">
			<div class="col-md-12 mb-4">
                <label class="font-weight-bold small text-muted">현재 등록된 이미지</label>
				<c:choose>
					<c:when test="${not empty product.fileList}">
						<div class="d-flex flex-wrap mt-2" id="fileBox">
							<c:forEach var="f" items="${product.fileList}">
								<div class="current-img-box file-box">
									<img src="/files/product/${f.fileName}">
									<button type="button" class="btn btn-danger delete-btn" data-file-num="${f.fileNum}">
										<i class="bi bi-x"></i>
									</button>
								</div>
							</c:forEach>
						</div>
					</c:when>
					<c:otherwise>
						<p class="text-muted small mt-2">등록된 이미지가 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
            
			<div class="col-md-12">
				<form:form action="/product/edit" method="post" modelAttribute="productDTO" enctype="multipart/form-data">
					<form:hidden path="productNum" />
					
                    <div class="form-group mb-4">
                        <label>상품명</label>
                        <form:input path="productTitle" class="form-control" placeholder="상품명을 입력하세요" />
                        <form:errors path="productTitle" cssClass="error-msg" />
                    </div>
					
                    <div class="form-group mb-4">
                        <label>가격 (원)</label>
                        <form:input path="productPrice" type="number" class="form-control" placeholder="가격을 입력해주세요" />
                        <form:errors path="productPrice" cssClass="error-msg" />
                    </div>
					
                    <div class="form-group mb-4">
                        <label>거래 지역</label>
                        <div class="input-group">
                            <form:input path="productLocation" id="productLocation" class="form-control" readonly="true" />
                            <div class="input-group-append">
                                <button type="button" class="btn btn-check" onclick="searchAddress()">주소 검색</button>
                            </div>
                        </div>
                        <form:errors path="productLocation" cssClass="error-msg" />
                    </div>
					
					<div class="row">
                        <div class="col-md-6 form-group mb-4">
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
                        
                        <div class="col-md-6 form-group mb-4">
                            <label>판매상태</label>
                            <form:select path="productStatus" class="form-control">
                                <form:option value="판매중">판매중</form:option>
                                <form:option value="거래중">거래중</form:option>
                                <form:option value="판매완료">판매완료</form:option>
                            </form:select>
                        </div>
                    </div>
					
					<div class="form-group mb-4">
						<label>상품 설명</label>
						<form:textarea path="productContent" class="form-control" rows="8" placeholder="설명을 입력해주세요" />
                        <form:errors path="productContent" cssClass="error-msg" />
					</div>
					
					<div class="form-group mb-4">
                        <label>이미지 추가</label>
                        <div class="input-group">
                            <input type="file" id="fileInput" name="file" multiple class="form-control-file border p-2 rounded" style="width: 100%;">
                            <button type="button" id="addFileBtn" class="btn btn-orange mt-2 btn-sm">이미지 즉시 추가</button>
                        </div>
                        <div id="previewBox" class="d-flex flex-wrap mt-2"></div>
					</div>
                    
                    <div class="d-flex gap-3 mt-5">
					    <button type="submit" class="btn btn-orange flex-grow-1 py-3">수정 완료</button>
					    <a href="/product/detail?productNum=${product.productNum}" class="btn btn-light flex-grow-1 py-3 border ml-3">취소</a>
                    </div>
				</form:form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/product/edit.js"></script>
</body>
</html>