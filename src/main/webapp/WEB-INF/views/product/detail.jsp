<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
							<a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
								<span class="carousel-control-prev-icon"></span>
							</a>
							<a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
								<span class="carousel-control-next-icon"></span>
							</a>
						</div>
					</c:when>
					<c:otherwise>
						<img src="/image/noImage.png" class="img-fluid">
					</c:otherwise>
				</c:choose>
				<div class="mt-3 d-flex">
					<c:forEach var="f" items="${product.fileList}" varStatus="status">
						<img src="/files/product/${f.fileName}" style="width: 80px; height: 80px; margin-right: 5px; cursor: pointer; object-fit: cover;" data-target="#productCarousel" data-slide-to="${status.index}">
					</c:forEach>
				</div>
			</div>
			<div class="col-md-6">
				<h2>
					${product.productTitle}
					<c:choose>
						<c:when test="${product.productStatus eq '거래중'}">
							<span class="badge badge-warning">${product.productStatus}</span>
						</c:when>
						<c:when test="${product.productStatus eq '판매완료'}">
							<span class="badge badge-success">${product.productStatus}</span>
						</c:when>
						<c:otherwise>
							<span class="badge badge-secondary">${product.productStatus}</span>
						</c:otherwise>
					</c:choose>
					<c:if test="${product.memberNum == loginUser.memberNum}">
						<a href="/product/edit?productNum=${product.productNum}" class="btn btn-outline-warning"> 수정 </a>
					</c:if>
					<c:if test="${product.memberNum == loginUser.memberNum}">
						<form action="./delete" method="post" style="display: inline;">
							<input type="hidden" name="productNum" value="${product.productNum}">
							<button type="submit" class="btn btn-outline-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
						</form>
					</c:if>
				</h2>
				<h4><fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원</h4>
				<p>${product.productLocation}</p>
				<p>${product.productType}</p>
				<hr>
				<pre>${product.productContent}</pre>
				<c:choose>
					<c:when test="${product.productStatus eq '판매완료'}">
						<button class="btn btn-secondary" disabled>구매불가</button>
					</c:when>
					<c:otherwise>
						<a href="/productChat/create?productNum=${product.productNum}" class="btn btn-outline-warning">구매 채팅</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
</body>
</html>