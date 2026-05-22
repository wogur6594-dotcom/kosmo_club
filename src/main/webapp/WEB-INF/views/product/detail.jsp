<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>${product.productTitle}-중고거래</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="/css/product.css">

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container detail-container">

		<div class="carousel-container mb-4">

			<c:choose>

				<c:when test="${not empty product.fileList}">

					<div id="productCarousel" class="carousel slide"
						data-ride="carousel">

						<div class="carousel-inner">

							<c:forEach var="f" items="${product.fileList}" varStatus="status">

								<div class="carousel-item ${status.index == 0 ? 'active' : ''}">

									<c:choose>

										<c:when test="${fn:startsWith(f.fileName, 'http')}">
											<img src="${f.fileName}" class="d-block w-100">
										</c:when>

										<c:otherwise>
											<img src="/files/product/${f.fileName}" class="d-block w-100">
										</c:otherwise>

									</c:choose>

								</div>

							</c:forEach>

						</div>

						<c:if test="${product.fileList.size() > 1}">

							<a class="carousel-control-prev" href="#productCarousel"
								role="button" data-slide="prev"> <span
								class="carousel-control-prev-icon"></span>

							</a>

							<a class="carousel-control-next" href="#productCarousel"
								role="button" data-slide="next"> <span
								class="carousel-control-next-icon"></span>

							</a>

						</c:if>

					</div>

				</c:when>

				<c:otherwise>

					<img src="/image/noImage.png" class="detail-no-image">

				</c:otherwise>

			</c:choose>

		</div>

		<c:if
			test="${not empty product.fileList and product.fileList.size() > 1}">

			<div class="thumbnail-bar">

				<c:forEach var="f" items="${product.fileList}" varStatus="status">

					<c:choose>

						<c:when test="${fn:startsWith(f.fileName, 'http')}">
							<img src="${f.fileName}"
								class="thumbnail-item ${status.index == 0 ? 'active' : ''}"
								data-target="#productCarousel" data-slide-to="${status.index}">
						</c:when>

						<c:otherwise>
							<img src="/files/product/${f.fileName}"
								class="thumbnail-item ${status.index == 0 ? 'active' : ''}"
								data-target="#productCarousel" data-slide-to="${status.index}">
						</c:otherwise>

					</c:choose>

				</c:forEach>

			</div>

		</c:if>

		<div class="seller-profile">

			<img src="/image/default.png" class="seller-img">

			<div class="seller-info">

				<div class="name">${product.member.memberId}</div>

				<div class="location">
					<i class="bi bi-geo-alt"></i> ${product.productLocation}
				</div>

			</div>

			<div class="ml-auto">

				<c:if test="${product.memberNum == loginUser.memberNum}">

					<div class="d-flex">

						<a href="/product/edit?productNum=${product.productNum}"
							class="btn btn-sm btn-outline-orange"> 수정 </a>

						<form action="./delete" method="post" class="d-inline">

							<input type="hidden" name="productNum"
								value="${product.productNum}">

							<button type="submit" class="btn btn-sm btn-outline-danger"
								onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>

						</form>

					</div>

				</c:if>

			</div>

		</div>

		<div class="product-info-section">

			<div class="d-flex align-items-start product-title-row">

				<c:choose>

					<c:when test="${product.productStatus eq '거래중'}">
						<span class="product-status status-reserved"> 예약중 </span>
					</c:when>

					<c:when test="${product.productStatus eq '판매완료'}">
						<span class="product-status status-sold"> 판매완료 </span>
					</c:when>

					<c:otherwise>
						<span class="product-status status-selling"> 판매중 </span>
					</c:otherwise>

				</c:choose>

				<h1 class="product-title m-0">${product.productTitle}</h1>

			</div>

			<div class="product-meta">
				${product.productType} &bull; <span class="time-ago">방금 전</span>
			</div>

			<div class="product-price">

				<fmt:formatNumber value="${product.productPrice}" pattern="#,###" />
				원

			</div>

			<div class="product-content">${product.productContent}</div>



			<div class="product-bottom-bar">

				<div class="detail-back-box">
					<a href="/product/list" class="btn btn-outline-orange"> 목록으로
						돌아가기 </a>
				</div>

				<div class="product-chat-info">

					<i class="bi bi-chat-dots"></i> <span> 채팅 </span> <span
						class="product-chat-count"> ${chatCount} </span>

				</div>

				<c:choose>

					<c:when test="${product.productStatus eq '판매완료'}">

						<button class="btn product-sold-btn" disabled>판매가 완료된
							상품입니다</button>

					</c:when>

					<c:otherwise>

						<a href="/productChat/create?productNum=${product.productNum}"
							class="btn btn-orange product-chat-btn"> 채팅하기 </a>

					</c:otherwise>

				</c:choose>

			</div>

		</div>

	</div>

	<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>



	<script>
		$('.thumbnail-item').click(function() {
			$('.thumbnail-item').removeClass('active');
			$(this).addClass('active');
		});
	</script>

</body>
</html>