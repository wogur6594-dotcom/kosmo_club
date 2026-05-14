<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>Insert title here</title>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	<h1>중고 거래</h1>
	<sec:authorize access="isAuthenticated()">
		<a class="btn btn-outline-dark" href="/product/add">상품 추가</a>
	</sec:authorize>
	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<form action="./list" method="get" class="mb-3">
					<div class="input-group">
						<input type="text" name="search" value="${pager.search}" class="form-control" placeholder="상품 검색">
						<div class="input-group-append">
							<button class="btn btn-dark" type="submit">검색</button>
						</div>
					</div>
				</form>
				<form action="./list" method="get">
					<div class="category-box">
						<label>
							<input type="checkbox" name="productType" value="디지털기기">
							디지털기기
						</label>
						<label>
							<input type="checkbox" name="productType" value="생활가전">
							생활가전
						</label>
						<label>
							<input type="checkbox" name="productType" value="가구/인테리어">
							가구/인테리어
						</label>
						<label>
							<input type="checkbox" name="productType" value="생활/주방">
							생활/주방
						</label>
						<label>
							<input type="checkbox" name="productType" value="유아물품">
							유아물품
						</label>
						<label>
							<input type="checkbox" name="productType" value="의류">
							의류
						</label>
						<label>
							<input type="checkbox" name="productType" value="잡화">
							잡화
						</label>
						<label>
							<input type="checkbox" name="productType" value="뷰티/미용">
							뷰티/미용
						</label>
						<label>
							<input type="checkbox" name="productType" value="스포츠/레저">
							스포츠/레저
						</label>
						<label>
							<input type="checkbox" name="productType" value="취미/게임/음반">
							취미/게임/음반
						</label>
						<label>
							<input type="checkbox" name="productType" value="티켓/e쿠폰">
							티켓/e쿠폰
						</label>
						<label>
							<input type="checkbox" name="productType" value="식품">
							식품
						</label>
						<label>
							<input type="checkbox" name="productType" value="기타">
							기타
						</label>
					</div>
				</form>
			</div>
			<div class="col-md-9">
				<div class="row">
					<c:forEach var="l" items="${list}">
						<div class="col-md-4 mb-4">
							<div class="card h-100">
								<c:choose>
									<c:when test="${not empty l.fileList and not empty l.fileList[0].fileName}">
										<img src="<c:url value='/files/product/${l.fileList[0].fileName}'/>" class="card-img-top">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/image/noImage.png'/>" class="card-img-top">
									</c:otherwise>
								</c:choose>
								<div class="card-body">
									<h5 class="card-title">
										<c:choose>
											<c:when test="${l.productStatus eq '거래중'}">
												<span class="badge badge-warning">${l.productStatus}</span>
											</c:when>
											<c:when test="${l.productStatus eq '판매완료'}">
												<span class="badge badge-success">${l.productStatus}</span>
											</c:when>
											<c:otherwise>
												<span class="badge badge-secondary">${l.productStatus}</span>
											</c:otherwise>
										</c:choose>
										${l.productTitle}
									</h5>
									<p class="card-text">${l.productPrice}원</p>
									<p class="card-text">${l.productLocation}</p>
									<a href="#" class="btn btn-outline-secondary">자세히보기</a>
								</div>

							</div>
						</div>
					</c:forEach>
				</div>
				<div class="row justify-content-center mt-3">
					<nav>
						<ul class="pagination">
							<li class="page-item ${pager.pre?'':'disabled'}">
								<a class="page-link" href="./list?page=${pager.pre ? pager.start-1 : pager.start}&search=${pager.search}&kind=${pager.kind}"> &laquo; </a>
							</li>
							<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
								<li class="page-item">
									<a class="page-link" href="./list?page=${i}&search=${pager.search}&kind=${pager.kind}"> ${i} </a>
								</li>
							</c:forEach>
							<li class="page-item ${pager.next?'':'disabled'}">
								<a class="page-link" href="./list?page=${pager.next ? pager.end+1 : pager.end}&search=${pager.search}&kind=${pager.kind}"> &raquo; </a>
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/product/list.js"></script>
</body>
</html>