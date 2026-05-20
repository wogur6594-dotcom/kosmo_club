<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:forEach var="l" items="${list}">
	<div class="col-6 col-md-4 mb-4 product-item">
        <a href="./detail?productNum=${l.productNum}" class="text-decoration-none">
            <div class="card product-card" style="border: none; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.06); background: white;">
                <div class="product-img-container" style="position: relative; padding-top: 100%; overflow: hidden;">
                    <c:choose>
                        <c:when test="${not empty l.fileList and not empty l.fileList[0].fileName}">
                            <img src="<c:url value='/files/product/${l.fileList[0].fileName}'/>" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="<c:url value='/image/noImage.png'/>" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="card-body p-3">
                    <div class="mb-1">
                        <c:choose>
                            <c:when test="${l.productStatus eq '거래중'}">
                                <span class="badge badge-warning" style="background-color: #31b247; color: white;">예약중</span>
                            </c:when>
                            <c:when test="${l.productStatus eq '판매완료'}">
                                <span class="badge badge-secondary" style="background-color: #adb5bd; color: white;">판매완료</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-light" style="background-color: #e9ecef; color: #495057;">판매중</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h5 class="product-title text-dark" style="font-size: 16px; font-weight: 500; margin-bottom: 4px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 48px;">${l.productTitle}</h5>
                    <div class="product-price text-dark" style="font-size: 18px; font-weight: bold; margin-bottom: 4px;"><fmt:formatNumber value="${l.productPrice}" pattern="#,###" />원</div>
                    <c:set var="addr" value="${fn:split(l.productLocation, ' ')}" />
                    <div class="product-location" style="font-size: 13px; color: #868e96;">${addr[0]} ${addr[1]}</div>
                </div>
            </div>
        </a>
	</div>
</c:forEach>