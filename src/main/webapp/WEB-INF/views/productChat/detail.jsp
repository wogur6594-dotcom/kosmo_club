<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>${product.productTitle} - 채팅</title>

<link rel="stylesheet" href="/css/chat.css">
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-light-orange: #fff1eb;
        --daangn-grey: #868e96;
        --daangn-light-grey: #f1f3f5;
    }
    body {
        background-color: white;
    }
    .chat-header {
        padding: 15px;
        border-bottom: 1px solid var(--daangn-light-grey);
        display: flex;
        align-items: center;
        background: white;
        position: sticky;
        top: 0;
        z-index: 100;
    }
    .product-mini-info {
        display: flex;
        align-items: center;
        gap: 10px;
        flex: 1;
    }
    .product-mini-img {
        width: 40px;
        height: 40px;
        border-radius: 6px;
        object-fit: cover;
    }
    .product-mini-text .title {
        font-weight: bold;
        font-size: 14px;
        display: block;
    }
    .product-mini-text .status {
        font-size: 11px;
        color: var(--daangn-orange);
    }
    
    .chat-box {
        background-color: white;
        height: calc(100vh - 180px);
        padding: 20px 15px;
    }
    
    .msg {
        max-width: 75%;
        margin-bottom: 15px;
    }
    .msg.me {
        align-self: flex-end;
    }
    .msg.me .content {
        background-color: var(--daangn-orange);
        color: white;
        border-radius: 18px 18px 2px 18px;
    }
    .msg.other .content {
        background-color: var(--daangn-light-grey);
        color: #212529;
        border-radius: 18px 18px 18px 2px;
    }
    .msg .content {
        padding: 10px 16px;
        font-size: 15px;
        box-shadow: none;
    }
    .msg .sender {
        font-size: 12px;
        color: var(--daangn-grey);
        margin-bottom: 4px;
        margin-left: 4px;
    }
    .msg.me .sender {
        display: none;
    }
    
    .msg.system {
        align-self: center;
        width: 100%;
        max-width: 100%;
        text-align: center;
        margin: 20px 0;
    }
    .msg.system .content {
        background: transparent;
        color: var(--daangn-grey);
        font-size: 12px;
        padding: 0;
    }
    
    .input-area {
        padding: 10px 15px;
        border-top: 1px solid var(--daangn-light-grey);
        display: flex;
        align-items: center;
        gap: 10px;
        background: white;
    }
    #message {
        background-color: var(--daangn-light-grey);
        border: none;
        border-radius: 20px;
        padding: 8px 18px;
        font-size: 15px;
    }
    #message:focus {
        outline: none;
        box-shadow: inset 0 0 0 1px var(--daangn-orange);
    }
    .btn-send {
        background: none;
        border: none;
        color: var(--daangn-orange);
        font-weight: bold;
        padding: 5px 10px;
    }
    .btn-plus {
        background: none;
        border: none;
        color: var(--daangn-grey);
        font-size: 20px;
        padding: 0;
    }
    
    .plus-menu {
        border-top: 1px solid var(--daangn-light-grey);
        background: #fcfcfc;
    }
    .plus-menu button {
        color: #495057;
    }
    .plus-menu i {
        color: #adb5bd !important;
    }
    .plus-menu button:hover i {
        color: var(--daangn-orange) !important;
    }
    
    .unread-badge {
        color: var(--daangn-orange);
        font-weight: bold;
        font-size: 10px;
        margin-right: 4px;
    }
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp" />

	<div class="container p-0 border-left border-right" style="max-width: 600px; min-height: 100vh; display: flex; flex-direction: column;">
        <div class="chat-header">
            <a href="javascript:history.back()" class="text-dark mr-3"><i class="bi bi-chevron-left"></i></a>
            <div class="product-mini-info">
                <c:if test="${not empty product.fileList}">
                    <img src="/files/product/${product.fileList[0].fileName}" class="product-mini-img">
                </c:if>
                <div class="product-mini-text">
                    <span class="title">${product.productTitle}</span>
                    <span class="status">
                        <c:choose>
                            <c:when test="${product.productStatus eq '거래중'}">예약중</c:when>
                            <c:when test="${product.productStatus eq '판매완료'}">판매완료</c:when>
                            <c:otherwise>판매중</c:otherwise>
                        </c:choose>
                        &bull; <fmt:formatNumber value="${product.productPrice}" pattern="#,###" />원
                    </span>
                </div>
            </div>
            <a href="/product/detail?productNum=${product.productNum}" class="btn btn-sm btn-outline-secondary">상품보기</a>
        </div>

		<div class="chat-box" id="chatBox">
			<c:forEach items="${messages}" var="m">
				<div class="msg ${m.type == 'system' ? 'system' : (m.senderNum == loginUser.memberNum ? 'me' : 'other')}">
					<c:if test="${m.type != 'system'}">
						<div class="sender">${m.senderName}</div>
					</c:if>
					<div class="content">
						<c:choose>
							<c:when test="${m.type == 'image'}">
								<img src="/files/chat/${m.messageContent}" alt="사진">
							</c:when>
							<c:when test="${m.type == 'map'}">
								<div><strong>[장소 공유]</strong></div>
								<div>${m.messageContent.split('|')[0]}</div>
								<a href="https://map.kakao.com/link/map/${m.messageContent.split('|')[0]},${m.messageContent.split('|')[1]}" target="_blank" class="map-btn">
									<i class="bi bi-geo-alt"></i> 지도 보기
								</a>
							</c:when>
							<c:otherwise>
								${m.messageContent}
							</c:otherwise>
						</c:choose>
					</div>
					<div class="meta">
						<%-- 시스템 메시지가 아니고, 내가 보낸 메시지이며, 아직 안 읽었을 때만 1 표시 --%>
						<c:if test="${m.type != 'system' && m.senderNum == loginUser.memberNum && !m.isRead}">
							<span class="unread-badge">1</span>
						</c:if>
                        <span class="time" data-time="${m.createtime}"></span>
					</div>
				</div>
			</c:forEach>
		</div>

		<div class="input-area">
			<button class="btn-plus" onclick="togglePlusMenu()">
				<i class="bi bi-plus-circle"></i>
			</button>
			<input type="text" id="message" class="form-control" placeholder="메시지 보내기">
			<button class="btn-send" onclick="sendMessage()">보내기</button>
		</div>

		<div class="plus-menu" id="plusMenu">
			<button onclick="document.getElementById('fileInput').click()">
				<i class="bi bi-image"></i>
				<div>사진</div>
			</button>
			<c:if test="${product.memberNum == loginUser.memberNum}">
				<div class="dropdown">
					<button class="dropdown-toggle" data-toggle="dropdown" style="border:none; background:none;">
						<i class="bi bi-tag" style="font-size: 24px;"></i>
						<div>상태변경</div>
					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="javascript:updateStatus('판매중')">판매중</a>
						<a class="dropdown-item" href="javascript:updateStatus('거래중')">거래중</a>
						<a class="dropdown-item" href="javascript:updateStatus('판매완료')">판매완료</a>
					</div>
				</div>
			</c:if>
			<button onclick="shareLocation()">
				<i class="bi bi-geo-alt"></i>
				<div>위치</div>
			</button>
		</div>
		<input type="file" id="fileInput" style="display:none" onchange="uploadFile(this)" accept="image/*">
	</div>

		<!-- 위치 선택 모달 -->
		<div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">장소 공유</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="input-group mb-3">
							<input type="text" id="mapSearchKeyword" class="form-control" placeholder="장소 검색 (예: 강남역)">
							<div class="input-group-append">
								<button class="btn btn-primary" onclick="searchPlacesInModal()">검색</button>
							</div>
						</div>
						<div id="modalMap" style="width: 100%; height: 400px; background: #eee;"></div>
						<div id="selectedAddress" class="mt-2 text-muted small">지도를 클릭하여 위치를 선택하세요.</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" onclick="confirmLocation()">이 위치 보내기</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Kakao Map SDK -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8718278b1ae57e3d4c204aad5927d12a&libraries=services"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
		<script>
			const chatroomNum = "${chatroomNum}";
			const loginUserNum = "${loginUser.memberNum}";
			const loginUserId = "${loginUser.memberId}";
			const productNum = "${product.productNum}";
		</script>
		<script src="/js/productChat/chat.js"></script>
		<!-- detail.jsp 맨 아래 -->
</body>
</html>
