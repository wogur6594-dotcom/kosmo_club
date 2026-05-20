<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>채팅방</title>

<link rel="stylesheet" href="/css/chat.css">
<style>
/* 추가 스타일 */
.plus-menu {
	display: none;
	background: #eee;
	padding: 10px;
	border-top: 1px solid #ddd;
	justify-content: space-around;
	flex-wrap: wrap;
}

.plus-menu button {
	background: none;
	border: none;
	display: flex;
	flex-direction: column;
	align-items: center;
	font-size: 12px;
	padding: 10px;
}

.plus-menu i {
	font-size: 24px;
	margin-bottom: 5px;
}

.msg.system {
	align-self: center;
	background: rgba(0, 0, 0, 0.1);
	color: #333;
	font-size: 12px;
	padding: 5px 15px;
	border-radius: 20px;
	text-align: center;
}

.msg img {
	max-width: 100%;
	border-radius: 8px;
	display: block;
	margin-top: 5px;
}

.unread-badge {
	color: #ff4d4f;
	font-size: 11px;
	margin-left: 4px;
}

.map-btn {
	background: white;
	border: 1px solid #ddd;
	padding: 5px 10px;
	border-radius: 5px;
	font-size: 12px;
	margin-top: 5px;
	display: inline-block;
	color: #333;
	text-decoration: none;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp" />

	<div class="container">

		<h3 class="mb-4">
			<i class="bi bi-chat-dots"></i>
			<span style="color: #007bff;">${product.productTitle}</span>
			채팅방
			<span id="productStatusBadge" class="badge badge-info ml-2">${product.productStatus}</span>
			<a href="/product/detail?productNum=${product.productNum}" class="btn btn-sm btn-outline-primary ml-2"> 상품보기 </a>
		</h3>

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
								<div>
									<strong>[장소 공유]</strong>
								</div>
								<div>${m.messageContent.split('|')[0]}</div>
								<a href="https://map.kakao.com/link/map/${m.messageContent.split('|')[0]},${m.messageContent.split('|')[1]}" target="_blank" class="map-btn">
									<i class="bi bi-geo-alt"></i>
									지도 보기
								</a>
							</c:when>
							<c:otherwise>
								${m.messageContent}
							</c:otherwise>
						</c:choose>
					</div>
					<div class="meta">
						<span class="time" data-time="${m.createtime}"></span>
						<%-- 시스템 메시지가 아니고, 내가 보낸 메시지이며, 아직 안 읽었을 때만 1 표시 --%>
						<c:if test="${m.type != 'system' && m.senderNum == loginUser.memberNum && !m.isRead}">
							<span class="unread-badge">1</span>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>

		<div class="input-area">
			<button class="btn btn-light" onclick="togglePlusMenu()">
				<i class="bi bi-plus-lg"></i>
			</button>
			<input type="text" id="message" placeholder="메시지 입력">
			<button class="btn btn-warning" onclick="sendMessage()">전송</button>
		</div>

		<div class="plus-menu" id="plusMenu">
			<button onclick="document.getElementById('fileInput').click()">
				<i class="bi bi-image text-primary"></i>
				<span>사진</span>
			</button>
			<c:if test="${product.memberNum == loginUser.memberNum}">
				<div class="dropdown">
					<button class="dropdown-toggle" data-toggle="dropdown" style="border: none; background: none;">
						<i class="bi bi-tag text-success" style="font-size: 24px;"></i>
						<div style="font-size: 12px;">상태변경</div>
					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="javascript:updateStatus('판매중')">판매중</a>
						<a class="dropdown-item" href="javascript:updateStatus('거래중')">거래중</a>
						<a class="dropdown-item" href="javascript:updateStatus('판매완료')">판매완료</a>
					</div>
				</div>
			</c:if>
			<button onclick="shareLocation()">
				<i class="bi bi-geo-alt text-danger"></i>
				<span>위치</span>
			</button>
			<input type="file" id="fileInput" style="display: none" onchange="uploadFile(this)" accept="image/*">
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
