<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>내 상품 - 당근 느낌</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-grey: #868e96;
    }
    body {
        background-color: #f8f9fa;
        color: #212529;
    }
    .page-title {
        font-weight: bold;
        color: #212529;
        margin-bottom: 30px;
    }
    .btn-orange {
        background-color: var(--daangn-orange);
        color: white;
        border: none;
        font-weight: bold;
    }
    .btn-orange:hover {
        background-color: #e67831;
        color: white;
    }
    .btn-outline-orange {
        border: 1px solid var(--daangn-orange);
        color: var(--daangn-orange);
        background: white;
        font-weight: bold;
    }
    .btn-outline-orange:hover {
        background-color: var(--daangn-orange);
        color: white;
    }
    .filter-section {
        background: white;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    .category-box label {
        display: block;
        padding: 5px 0;
        cursor: pointer;
        font-size: 14px;
    }
    .category-box input[type="radio"] {
        margin-right: 8px;
        accent-color: var(--daangn-orange);
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="container mt-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="page-title m-0">내 판매 목록</h2>
            <sec:authorize access="isAuthenticated()">
                <a class="btn btn-orange px-4" href="/product/add">상품 등록하기</a>
            </sec:authorize>
        </div>

		<div class="row">
			<!-- ================= LEFT FILTER ================= -->
			<div class="col-md-3 mb-4">
                <div class="filter-section">
                    <form action="./myList" method="get" onsubmit="return false;">
                        <!-- 검색 -->
                        <div class="input-group mb-4">
                            <input type="text" name="search" value="${pager.search}" class="form-control border-right-0" placeholder="내 상품 검색">
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary border-left-0" type="submit">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                        </div>

                        <!-- ================= 지역 필터 ================= -->
                        <label class="font-weight-bold mb-2">지역</label>
                        <div class="category-box mb-4" style="max-height: 200px; overflow-y: auto;">
                            <label><input type="radio" name="productLocation" value="" ${empty pager.productLocation ? 'checked' : ''}> 전체</label>
                            <label><input type="radio" name="productLocation" value="서울" ${pager.productLocation eq '서울' ? 'checked' : ''}> 서울</label>
                            <label><input type="radio" name="productLocation" value="경기" ${pager.productLocation eq '경기' ? 'checked' : ''}> 경기</label>
                            <label><input type="radio" name="productLocation" value="인천" ${pager.productLocation eq '인천' ? 'checked' : ''}> 인천</label>
                            <label><input type="radio" name="productLocation" value="강원" ${pager.productLocation eq '강원' ? 'checked' : ''}> 강원</label>
                            <label><input type="radio" name="productLocation" value="대전" ${pager.productLocation eq '대전' ? 'checked' : ''}> 대전</label>
                            <label><input type="radio" name="productLocation" value="세종" ${pager.productLocation eq '세종' ? 'checked' : ''}> 세종</label>
                            <label><input type="radio" name="productLocation" value="충북" ${pager.productLocation eq '충북' ? 'checked' : ''}> 충북</label>
                            <label><input type="radio" name="productLocation" value="충남" ${pager.productLocation eq '충남' ? 'checked' : ''}> 충남</label>
                            <label><input type="radio" name="productLocation" value="대구" ${pager.productLocation eq '대구' ? 'checked' : ''}> 대구</label>
                            <label><input type="radio" name="productLocation" value="경북" ${pager.productLocation eq '경북' ? 'checked' : ''}> 경북</label>
                            <label><input type="radio" name="productLocation" value="부산" ${pager.productLocation eq '부산' ? 'checked' : ''}> 부산</label>
                            <label><input type="radio" name="productLocation" value="울산" ${pager.productLocation eq '울산' ? 'checked' : ''}> 울산</label>
                            <label><input type="radio" name="productLocation" value="경남" ${pager.productLocation eq '경남' ? 'checked' : ''}> 경남</label>
                            <label><input type="radio" name="productLocation" value="광주" ${pager.productLocation eq '광주' ? 'checked' : ''}> 광주</label>
                            <label><input type="radio" name="productLocation" value="전북" ${pager.productLocation eq '전북' ? 'checked' : ''}> 전북</label>
                            <label><input type="radio" name="productLocation" value="전남" ${pager.productLocation eq '전남' ? 'checked' : ''}> 전남</label>
                            <label><input type="radio" name="productLocation" value="제주" ${pager.productLocation eq '제주' ? 'checked' : ''}> 제주</label>
                        </div>

                        <!-- ================= 카테고리 ================= -->
                        <label class="font-weight-bold mb-2">카테고리</label>
                        <div class="category-box" style="max-height: 200px; overflow-y: auto;">
                            <label><input type="radio" name="productType" value="" ${empty pager.productType ? 'checked' : ''}> 전체</label>
                            <label><input type="radio" name="productType" value="디지털기기" ${fn:contains(pager.productType, '디지털기기') ? 'checked' : ''}> 디지털기기</label>
                            <label><input type="radio" name="productType" value="생활가전" ${fn:contains(pager.productType, '생활가전') ? 'checked' : ''}> 생활가전</label>
                            <label><input type="radio" name="productType" value="가구/인테리어" ${fn:contains(pager.productType, '가구/인테리어') ? 'checked' : ''}> 가구/인테리어</label>
                            <label><input type="radio" name="productType" value="생활/주방" ${fn:contains(pager.productType, '생활/주방') ? 'checked' : ''}> 생활/주방</label>
                            <label><input type="radio" name="productType" value="유아물품" ${fn:contains(pager.productType, '유아물품') ? 'checked' : ''}> 유아물품</label>
                            <label><input type="radio" name="productType" value="의류" ${fn:contains(pager.productType, '의류') ? 'checked' : ''}> 의류</label>
                            <label><input type="radio" name="productType" value="잡화" ${fn:contains(pager.productType, '잡화') ? 'checked' : ''}> 잡화</label>
                            <label><input type="radio" name="productType" value="뷰티/미용" ${fn:contains(pager.productType, '뷰티/미용') ? 'checked' : ''}> 뷰티/미용</label>
                            <label><input type="radio" name="productType" value="스포츠/레저" ${fn:contains(pager.productType, '스포츠/레저') ? 'checked' : ''}> 스포츠/레저</label>
                            <label><input type="radio" name="productType" value="취미/게임/음반" ${fn:contains(pager.productType, '취미/게임/음반') ? 'checked' : ''}> 취미/게임/음반</label>
                            <label><input type="radio" name="productType" value="티켓/e쿠폰" ${fn:contains(pager.productType, '티켓/e쿠폰') ? 'checked' : ''}> 티켓/e쿠폰</label>
                            <label><input type="radio" name="productType" value="식품" ${fn:contains(pager.productType, '식품') ? 'checked' : ''}> 식품</label>
                            <label><input type="radio" name="productType" value="기타" ${fn:contains(pager.productType, '기타') ? 'checked' : ''}> 기타</label>
                        </div>
                    </form>
                </div>
			</div>

			<!-- ================= RIGHT LIST ================= -->
			<div class="col-md-9">
				<div class="row" id="productContainer"></div>
				<div id="scrollTrigger" style="height: 10px;"></div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.min.js"></script>
	<script src="/js/product/myList.js"></script>
</body>
</html>