<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:forEach var="l" items="${list}">
	<div class="col-md-4 mb-4 product-item">
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
				<c:set var="addr" value="${fn:split(l.productLocation, ' ')}" />
				<p class="card-text">${addr[0]}&nbsp;${addr[1]}</p>
				<a href="./detail?productNum=${l.productNum}" class="btn btn-outline-secondary"> 자세히보기 </a>
			</div>
		</div>
	</div>
</c:forEach>