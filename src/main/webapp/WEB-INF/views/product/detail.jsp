<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>${product.productTitle} - 당근 느낌</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-grey: #868e96;
        --daangn-light-grey: #f1f3f5;
    }
    body {
        background-color: #ffffff;
        color: #212529;
    }
    .detail-container {
        max-width: 720px;
        margin: 40px auto;
    }
    .carousel-container {
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        background: #000;
    }
    .carousel-item img {
        height: 500px;
        object-fit: contain;
    }
    .thumbnail-bar {
        display: flex;
        gap: 10px;
        margin-top: 15px;
        overflow-x: auto;
        padding-bottom: 5px;
    }
    .thumbnail-item {
        width: 70px;
        height: 70px;
        border-radius: 8px;
        object-fit: cover;
        cursor: pointer;
        border: 2px solid transparent;
        transition: border-color 0.2s;
    }
    .thumbnail-item:hover, .thumbnail-item.active {
        border-color: var(--daangn-orange);
    }
    
    .seller-profile {
        display: flex;
        align-items: center;
        padding: 20px 0;
        border-bottom: 1px solid var(--daangn-light-grey);
        margin-bottom: 20px;
    }
    .seller-img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
        margin-right: 12px;
    }
    .seller-info .name {
        font-weight: bold;
        font-size: 16px;
        margin-bottom: 2px;
    }
    .seller-info .location {
        font-size: 13px;
        color: var(--daangn-grey);
    }
    
    .product-info-section {
        padding: 20px 0;
    }
    .product-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 8px;
    }
    .product-meta {
        font-size: 14px;
        color: var(--daangn-grey);
        margin-bottom: 15px;
    }
    .product-price {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
    }
    .product-content {
        font-size: 17px;
        line-height: 1.6;
        white-space: pre-wrap;
        margin-bottom: 40px;
    }
    
    .btn-orange {
        background-color: var(--daangn-orange);
        color: white;
        border: none;
        font-weight: bold;
        padding: 12px 24px;
        border-radius: 8px;
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
        padding: 10px 20px;
        border-radius: 8px;
    }
    .btn-outline-orange:hover {
        background-color: #fffaf0;
        color: var(--daangn-orange);
    }
</style>
</head>

<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="container detail-container">
		<div class="carousel-container mb-4">
            <c:choose>
                <c:when test="${not empty product.fileList}">
                    <div id="productCarousel" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <c:forEach var="f" items="${product.fileList}" varStatus="status">
                                <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                    <c:choose>
                                        <c:when test="${fn:startsWith(f.fileName, 'http')}">
                                            <img src="${f.fileName}" class="d-block w-100">
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                        <c:when test="${fn:startsWith(f.fileName, 'http')}">
                                            <img src="${f.fileName}" class="d-block w-100">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/files/product/${f.fileName}" class="d-block w-100">
                                        </c:otherwise>
                                    </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                        <c:if test="${product.fileList.size() > 1}">
                            <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
                                <span class="carousel-control-prev-icon"></span>
                            </a>
                            <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
                                <span class="carousel-control-next-icon"></span>
                            </a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <img src="/image/noImage.png" class="img-fluid w-100" style="height: 400px; object-fit: cover;">
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="thumbnail-bar">
            <c:forEach var="f" items="${product.fileList}" varStatus="status">
                <c:choose>
                    <c:when test="${fn:startsWith(f.fileName, 'http')}">
                        <img src="${f.fileName}" class="thumbnail-item ${status.index == 0 ? 'active' : ''}" data-target="#productCarousel" data-slide-to="${status.index}">
                    </c:when>
                    <c:otherwise>
                        <img src="/files/product/${f.fileName}" class="thumbnail-item ${status.index == 0 ? 'active' : ''}" data-target="#productCarousel" data-slide-to="${status.index}">
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

        <div class="seller-profile">
            <img src="/image/default.png" class="seller-img">
            <div class="seller-info">
                <div class="name">${product.member.memberId}</div>
                <div class="location">${product.productLocation}</div>
            </div>
            <div class="ml-auto">
                <c:if test="${product.memberNum == loginUser.memberNum}">
                    <div class="d-flex gap-2">
                        <a href="/product/edit?productNum=${product.productNum}" class="btn btn-sm btn-outline-orange mr-2">수정</a>
                        <form action="./delete" method="post" class="d-inline">
                            <input type="hidden" name="productNum" value="${product.productNum}">
                            <button type="submit" class="btn btn-sm btn-outline-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>

        <div class="product-info-section">
            <div class="d-flex align-items-center mb-2">
                <c:choose>
                    <c:when test="${product.productStatus eq '거래중'}">
                        <span class="badge badge-warning p-2 mr-2" style="background-color: #31b247; color: white;">예약중</span>
                    </c:when>
                    <c:when test="${product.productStatus eq '판매완료'}">
                        <span class="badge badge-secondary p-2 mr-2" style="background-color: #adb5bd; color: white;">판매완료</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-light p-2 mr-2" style="background-color: #e9ecef; color: #495057;">판매중</span>
                    </c:otherwise>
                </c:choose>
                <h1 class="product-title m-0">${product.productTitle}</h1>
            </div>
            <div class="product-meta">${product.productType} &bull; <span class="time-ago">방금 전</span></div>
            <div class="product-price"><fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원</div>
            <div class="product-content">${product.productContent}</div>
            
            <hr>
            
            <div class="d-flex justify-content-between align-items-center">
                <div class="text-muted small">채팅 ${chatCount}</div>
                <c:choose>
                    <c:when test="${product.productStatus eq '판매완료'}">
                        <button class="btn btn-secondary px-5 py-3" disabled>판매가 완료된 상품입니다</button>
                    </c:when>
                    <c:otherwise>
                        <a href="/productChat/create?productNum=${product.productNum}" class="btn btn-orange px-5 py-2" style="font-size: 18px;">채팅하기</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script>
        $('.thumbnail-item').click(function() {
            $('.thumbnail-item').removeClass('active');
            $(this).addClass('active');
        });
    </script>
</body>
</html>