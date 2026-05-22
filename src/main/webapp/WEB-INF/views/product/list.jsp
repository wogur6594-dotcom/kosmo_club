<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>중고거래</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="/css/product.css">

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="product-wrap container">

		<div
			class="page-head d-flex justify-content-between align-items-center">

			<div>
				<h2 class="page-title">중고거래</h2>
				<div class="page-subtitle">우리 동네에서 필요한 물건을 사고팔아보세요.</div>
			</div>

			<sec:authorize access="isAuthenticated()">
				<a class="btn btn-brown" href="/product/add"> <i
					class="bi bi-plus-circle mr-1"></i> 상품 등록

				</a>
			</sec:authorize>

		</div>

		<div class="row">

			<div class="col-md-3 mb-4">

				<div class="filter-section">

					<form action="./list" method="get">

						<div class="input-group mb-4">

							<input type="text" name="search" value="${pager.search}"
								class="form-control search-input" placeholder="상품 검색">

							<div class="input-group-append">

								<button class="btn search-btn" type="submit">

									<i class="bi bi-search"></i>

								</button>

							</div>

						</div>

						<div class="filter-title">지역</div>

						<div class="category-box mb-4">

							<label> <input type="radio" name="productLocation"
								value="" ${empty pager.productLocation ? 'checked' : ''}>
								전체
							</label> <label> <input type="radio" name="productLocation"
								value="서울" ${pager.productLocation eq '서울' ? 'checked' : ''}>
								서울
							</label> <label> <input type="radio" name="productLocation"
								value="경기" ${pager.productLocation eq '경기' ? 'checked' : ''}>
								경기
							</label> <label> <input type="radio" name="productLocation"
								value="인천" ${pager.productLocation eq '인천' ? 'checked' : ''}>
								인천
							</label> <label> <input type="radio" name="productLocation"
								value="강원" ${pager.productLocation eq '강원' ? 'checked' : ''}>
								강원
							</label> <label> <input type="radio" name="productLocation"
								value="부산" ${pager.productLocation eq '부산' ? 'checked' : ''}>
								부산
							</label> <label> <input type="radio" name="productLocation"
								value="대구" ${pager.productLocation eq '대구' ? 'checked' : ''}>
								대구
							</label> <label> <input type="radio" name="productLocation"
								value="광주" ${pager.productLocation eq '광주' ? 'checked' : ''}>
								광주
							</label> <label> <input type="radio" name="productLocation"
								value="대전" ${pager.productLocation eq '대전' ? 'checked' : ''}>
								대전
							</label> <label> <input type="radio" name="productLocation"
								value="울산" ${pager.productLocation eq '울산' ? 'checked' : ''}>
								울산
							</label> <label> <input type="radio" name="productLocation"
								value="세종" ${pager.productLocation eq '세종' ? 'checked' : ''}>
								세종
							</label> <label> <input type="radio" name="productLocation"
								value="충북" ${pager.productLocation eq '충북' ? 'checked' : ''}>
								충북
							</label> <label> <input type="radio" name="productLocation"
								value="충남" ${pager.productLocation eq '충남' ? 'checked' : ''}>
								충남
							</label> <label> <input type="radio" name="productLocation"
								value="전북" ${pager.productLocation eq '전북' ? 'checked' : ''}>
								전북
							</label> <label> <input type="radio" name="productLocation"
								value="전남" ${pager.productLocation eq '전남' ? 'checked' : ''}>
								전남
							</label> <label> <input type="radio" name="productLocation"
								value="경북" ${pager.productLocation eq '경북' ? 'checked' : ''}>
								경북
							</label> <label> <input type="radio" name="productLocation"
								value="경남" ${pager.productLocation eq '경남' ? 'checked' : ''}>
								경남
							</label> <label> <input type="radio" name="productLocation"
								value="제주" ${pager.productLocation eq '제주' ? 'checked' : ''}>
								제주
							</label>

						</div>

						<div class="filter-title">카테고리</div>

						<div class="category-box">

							<label> <input type="radio" name="productType" value=""
								${empty pager.productType ? 'checked' : ''}> 전체
							</label> <label> <input type="radio" name="productType"
								value="디지털기기" ${pager.productType eq '디지털기기' ? 'checked' : ''}>
								디지털기기
							</label> <label> <input type="radio" name="productType"
								value="생활가전" ${pager.productType eq '생활가전' ? 'checked' : ''}>
								생활가전
							</label> <label> <input type="radio" name="productType"
								value="가구/인테리어"
								${pager.productType eq '가구/인테리어' ? 'checked' : ''}>
								가구/인테리어
							</label> <label> <input type="radio" name="productType"
								value="생활/주방" ${pager.productType eq '생활/주방' ? 'checked' : ''}>
								생활/주방
							</label> <label> <input type="radio" name="productType"
								value="의류" ${pager.productType eq '의류' ? 'checked' : ''}>
								의류
							</label> <label> <input type="radio" name="productType"
								value="잡화" ${pager.productType eq '잡화' ? 'checked' : ''}>
								잡화
							</label> <label> <input type="radio" name="productType"
								value="취미/게임/음반"
								${pager.productType eq '취미/게임/음반' ? 'checked' : ''}>
								취미/게임/음반
							</label> <label> <input type="radio" name="productType"
								value="기타" ${pager.productType eq '기타' ? 'checked' : ''}>
								기타
							</label>

						</div>

					</form>

				</div>

			</div>

			<div class="col-md-9">

				<c:choose>

					<c:when test="${empty list}">

						<div class="empty-box">

							<i class="bi bi-box-seam" style="font-size: 38px;"></i>

							<div class="mt-3">등록된 상품이 없습니다.</div>

						</div>

					</c:when>

					<c:otherwise>

						<div class="row">

							<c:forEach var="l" items="${list}">

								<div class="col-6 col-lg-4 mb-4">

									<a href="./detail?productNum=${l.productNum}"
										class="product-card-link">

										<div class="product-card">

											<div class="product-img-box">

												<c:choose>

													<c:when
														test="${not empty l.fileList and not empty l.fileList[0].fileName}">

														<c:choose>

															<c:when
																test="${fn:startsWith(l.fileList[0].fileName, 'http')}">

																<img src="${l.fileList[0].fileName}">

															</c:when>

															<c:otherwise>

																<img src="/files/product/${l.fileList[0].fileName}">

															</c:otherwise>

														</c:choose>

													</c:when>

													<c:otherwise>

														<img src="/image/noImage.png">

													</c:otherwise>

												</c:choose>

											</div>

											<div class="product-body">

												<c:choose>

													<c:when test="${l.productStatus eq '거래중'}">

														<span class="product-status status-reserved"> 예약중 </span>

													</c:when>

													<c:when test="${l.productStatus eq '판매완료'}">

														<span class="product-status status-sold"> 판매완료 </span>

													</c:when>

													<c:otherwise>

														<span class="product-status status-selling"> 판매중 </span>

													</c:otherwise>

												</c:choose>

												<div class="product-title">${l.productTitle}</div>

												<div class="product-price">

													<fmt:formatNumber value="${l.productPrice}" pattern="#,###" />
													원

												</div>

												<div class="product-location">

													<i class="bi bi-geo-alt"></i> ${l.productLocation}

												</div>

											</div>

										</div>

									</a>

								</div>

							</c:forEach>

						</div>

					</c:otherwise>

				</c:choose>

				<c:if test="${pager.totalCount > 0}">

					<div class="row justify-content-center mt-3">

						<nav>

							<ul class="pagination">

								<li class="page-item ${pager.pre ? '' : 'disabled'}"><a
									class="page-link"
									href="./list?page=${pager.start-1}&search=${pager.search}&productLocation=${pager.productLocation}&productType=${pager.productType}">

										« </a></li>

								<c:forEach begin="${pager.start}" end="${pager.end}" var="i">

									<li class="page-item ${pager.page == i ? 'active' : ''}">

										<a class="page-link"
										href="./list?page=${i}&search=${pager.search}&productLocation=${pager.productLocation}&productType=${pager.productType}">

											${i} </a>

									</li>

								</c:forEach>

								<li class="page-item ${pager.next ? '' : 'disabled'}"><a
									class="page-link"
									href="./list?page=${pager.end+1}&search=${pager.search}&productLocation=${pager.productLocation}&productType=${pager.productType}">

										» </a></li>

							</ul>

						</nav>

					</div>

				</c:if>

			</div>

		</div>

	</div>

	<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>

	<script src="/js/product/list.js"></script>

</body>
</html>