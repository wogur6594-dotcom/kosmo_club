<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="/css/topbar.css">

<nav class="navbar navbar-expand-lg navbar-light custom-topbar">
	<div class="container">

		<a class="navbar-brand topbar-brand" href="/"> Kosmo Project </a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">

			<ul class="navbar-nav ml-5">

				<li class="nav-item dropdown mr-4"><a
					class="nav-link dropdown-toggle topbar-menu-link" href="#"
					id="tradeDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> 중고거래 </a>

					<div class="dropdown-menu topbar-dropdown"
						aria-labelledby="tradeDropdown">
						<a class="dropdown-item" href="/product/list">상품목록</a> <a
							class="dropdown-item" href="/product/myList">내 판매목록</a> <a
							class="dropdown-item" href="/productChat/list">채팅방</a>
					</div></li>

				<li class="nav-item mr-4"><a class="nav-link topbar-menu-link"
					href="/club/list">동호회</a></li>

				<li class="nav-item mr-4"><a class="nav-link topbar-menu-link"
					href="/restaurant/list">동네맛집</a></li>

				<li class="nav-item"><a class="nav-link topbar-menu-link"
					href="/job/list">동네알바</a></li>

			</ul>

			<sec:authorize access="!isAuthenticated()">
				<div class="ml-auto topbar-auth-area">
					<a href="/member/signUp" class="topbar-btn"> 회원가입 </a> <a
						href="/member/login" class="topbar-btn"> 로그인 </a>
				</div>
			</sec:authorize>

			<sec:authorize access="isAuthenticated()">
				<div class="ml-auto topbar-auth-area">
					<div class="topbar-user-name">
						<sec:authentication property="principal.memberName" />
						님
					</div>

					<div class="dropdown d-inline-block mr-2">

						<button class="topbar-alert-btn dropdown-toggle" type="button"
							id="notificationDropdown" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false">
							🔔 알림

							<c:if test="${notificationCount gt 0}">
								<span class="badge badge-danger ml-1">
									${notificationCount} </span>
							</c:if>
						</button>

						<div
							class="dropdown-menu dropdown-menu-right topbar-notification-menu"
							aria-labelledby="notificationDropdown">

							<c:choose>
								<c:when test="${not empty recentNotifications}">
									<c:forEach items="${recentNotifications}" var="dto">

										<c:if test="${not empty dto.notificationNum}">
											<a class="dropdown-item topbar-notification-item"
												href="/notification/read?notificationNum=${dto.notificationNum}&url=${dto.notificationUrl}">

												<div class="topbar-notification-text">
													${dto.notificationContents}

													<c:if test="${!dto.isRead}">
														<span class="badge badge-warning ml-1"> NEW </span>
													</c:if>
												</div>

												<div class="topbar-notification-date">
													${dto.formatDate}</div>

											</a>
										</c:if>

									</c:forEach>
								</c:when>

								<c:otherwise>
									<div class="text-center text-muted p-3">알림이 없습니다.</div>
								</c:otherwise>
							</c:choose>

							<div class="dropdown-divider"></div>

							<a href="/notification/list"
								class="dropdown-item text-center topbar-notification-more">
								전체 알림 보기 </a>

						</div>

					</div>

					<a href="/member/detail" class="topbar-btn"> 회원정보 </a> <a
						href="/member/logout" class="topbar-btn"> 로그아웃 </a>

				</div>
			</sec:authorize>

		</div>
	</div>
</nav>

<script>
	(function connectNotificationSocket() {
		const socket = new WebSocket("ws://" + location.host
				+ "/ws/productChat?chatroomNum=list");

		socket.onmessage = function(event) {
			const msg = JSON.parse(event.data);

			if (msg.type === "notification") {
				const badge = document
						.querySelector("#notificationDropdown .badge");

				if (badge) {
					badge.innerText = parseInt(badge.innerText) + 1;
				} else {
					const btn = document.getElementById("notificationDropdown");
					btn.insertAdjacentHTML("beforeend",
							'<span class="badge badge-danger ml-1">1</span>');
				}

				const dropdownMenu = document
						.querySelector(".topbar-notification-menu");
				const noNoti = dropdownMenu
						.querySelector(".text-center.text-muted");

				if (noNoti) {
					noNoti.remove();
				}

				const newNoti = document.createElement("a");
				newNoti.className = "dropdown-item topbar-notification-item";
				newNoti.href = "/notification/list";

				newNoti.innerHTML = '<div class="topbar-notification-text">'
						+ msg.messageContent
						+ '<span class="badge badge-warning ml-1">NEW</span></div>'
						+ '<div class="topbar-notification-date">방금 전</div>';

				dropdownMenu.insertBefore(newNoti, dropdownMenu.firstChild);
			}
		};

		socket.onclose = function() {
			setTimeout(connectNotificationSocket, 5000);
		};
	})();
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>