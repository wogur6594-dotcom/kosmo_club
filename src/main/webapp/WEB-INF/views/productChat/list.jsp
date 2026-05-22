<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>채팅 목록 - 당근 느낌</title>
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
    .chat-container {
        max-width: 600px;
        margin: 0 auto;
        min-height: 100vh;
    }
    .header {
        padding: 20px;
        font-size: 18px;
        font-weight: bold;
        border-bottom: 1px solid var(--daangn-light-grey);
        background: white;
        position: sticky;
        top: 0;
        z-index: 10;
    }
    .chat-item {
        padding: 16px;
        display: flex;
        align-items: center;
        text-decoration: none;
        color: inherit;
        border-bottom: 1px solid var(--daangn-light-grey);
        transition: background-color 0.2s;
    }
    .chat-item:hover {
        background-color: #f8f9fa;
        text-decoration: none;
        color: inherit;
    }
    .thumb {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
        margin-right: 15px;
        border: 1px solid rgba(0,0,0,0.05);
    }
    .info {
        flex: 1;
        min-width: 0;
    }
    .product-name {
        font-size: 12px;
        color: var(--daangn-orange);
        margin-bottom: 2px;
        font-weight: 500;
    }
    .other-name {
        font-weight: bold;
        font-size: 15px;
        margin-bottom: 4px;
        display: block;
    }
    .last-message {
        font-size: 14px;
        color: #495057;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        display: block;
    }
    .meta-info {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 6px;
        margin-left: 10px;
    }
    .last-time {
        font-size: 12px;
        color: var(--daangn-grey);
    }
    .unread-badge {
        background: var(--daangn-orange);
        color: white;
        font-size: 11px;
        font-weight: bold;
        padding: 2px 7px;
        border-radius: 12px;
        min-width: 19px;
        text-align: center;
    }
    .delete-chat-btn {
        opacity: 0;
        transition: opacity 0.2s;
        font-size: 12px;
        padding: 2px 8px;
    }
    .chat-item:hover .delete-chat-btn {
        opacity: 1;
    }
</style>
</head>

<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="chat-container">
		<div class="header">채팅</div>
		<div id="chatList">
			<c:if test="${not empty msg}">
				<div class="alert alert-warning alert-dismissible fade show m-3 small p-2" role="alert">
					${msg}
					<button type="button" class="close" data-dismiss="alert" style="padding: 0.5rem;">
						<span>&times;</span>
					</button>
				</div>
			</c:if>
			
			<c:forEach items="${list}" var="c">
				<a id="room-${c.chatroomNum}" class="chat-item" href="/productChat/detail?chatroomNum=${c.chatroomNum}">
					<c:set var="profileImg" value="${c.otherProfileImage}" />
					<c:choose>
						<c:when test="${empty profileImg}">
							<img class="thumb" src="/image/default.png">
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${fn:startsWith(profileImg, 'http')}">
									<img class="thumb" src="${profileImg}" onerror="this.src='/image/default.png'">
								</c:when>
								<c:otherwise>
									<img class="thumb" src="/files/memberProfile/${profileImg}" onerror="this.src='/image/default.png'">
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					
					<div class="info">
						<div class="product-name">
							<i class="bi bi-box-seam"></i> ${c.productName}
						</div>
						<span class="other-name">${c.otherName}</span>
						<span class="last-message">
							<c:choose>
								<c:when test="${empty c.lastMessage}">대화를 시작해보세요!</c:when>
								<c:otherwise>${c.lastMessage}</c:otherwise>
							</c:choose>
						</span>
					</div>
					
					<div class="meta-info">
						<div class="last-time" data-time="${c.lastMessageTime != null ? c.lastMessageTime : c.createtime}"></div>
						<div class="badge-container">
							<c:if test="${c.unreadCount > 0}">
								<div class="unread-badge">${c.unreadCount}</div>
							</c:if>
						</div>
						<button class="btn btn-sm btn-outline-danger delete-chat-btn" onclick="event.preventDefault(); deleteChat(${c.chatroomNum});">삭제</button>
					</div>
				</a>
			</c:forEach>
            
            <c:if test="${empty list}">
                <div class="text-center mt-5 text-muted">
                    <i class="bi bi-chat-dots" style="font-size: 48px; opacity: 0.3;"></i>
                    <p class="mt-3">아직 채팅 내역이 없어요.</p>
                </div>
            </c:if>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script>
		const loginUserNum = "${loginUser.memberNum}";
	</script>
	<script src="/js/productChat/list.js"></script>
	<script>
		function formatTime(time) {
			if (!time) return "";
			if (typeof time === "string") {
				time = time.split(".")[0];
				const [date, t] = time.split("T");
				if (t) {
					const [h, m] = t.split(":");
					return h + ":" + m;
				}
			}
			let d = new Date(time);
			if (!isNaN(d.getTime())) {
				return String(d.getHours()).padStart(2, '0') + ":" + String(d.getMinutes()).padStart(2, '0');
			}
			return "";
		}

		document.querySelectorAll(".last-time").forEach(el => {
			const raw = el.dataset.time;
			if (raw) {
				el.innerText = formatTime(raw);
			}
		});
	</script>
</body>
</html>
