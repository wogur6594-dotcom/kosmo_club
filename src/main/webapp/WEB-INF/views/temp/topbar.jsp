<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<nav class="navbar navbar-expand-lg navbar-light"
	style="background-color: #fff7f3; border-bottom: 1px solid #d8cfc8;">

	<div class="container">

		<a class="navbar-brand font-weight-bold" href="/"
			style="color: #a35400; font-size: 32px;"> Kosmo Project </a>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav">

			<span class="navbar-toggler-icon"></span>

		</button>

		<div class="collapse navbar-collapse" id="navbarNav">

			<ul class="navbar-nav ml-5">


				<li class="nav-item dropdown mr-4">
					<a class="nav-link dropdown-toggle font-weight-bold" href="#" id="tradeDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="color: #5a3d2b;">중고거래</a>
					<div class="dropdown-menu" aria-labelledby="tradeDropdown">
						<a class="dropdown-item" href="/product/list">상품목록</a>
						<a class="dropdown-item" href="/product/myList">내 판매목록</a>
						<a class="dropdown-item" href="#">채팅방</a>
					</div>
				</li>

				<li class="nav-item mr-4"><a class="nav-link font-weight-bold"
					href="/club/list"
					style="color: #a35400;"> 동호회
				</a></li>

				<li class="nav-item mr-4"><a class="nav-link font-weight-bold"
					href="#" style="color: #a35400;"> ???? </a></li>

				<li class="nav-item"><a class="nav-link font-weight-bold"
					href="/job/list" style="color: #a35400;"> 동네알바 </a></li>

			</ul>

			<sec:authorize access="!isAuthenticated()">

				<div class="ml-auto">

					<a href="/member/signUp" class="btn btn-sm mr-2"
						style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;">
						회원가입 </a> <a href="/member/login" class="btn btn-sm"
						style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;">
						로그인 </a>

				</div>

			</sec:authorize>

			<sec:authorize access="isAuthenticated()">

				<div class="ml-auto">

					<div class="dropdown d-inline-block mr-2">

						<button class="btn btn-sm dropdown-toggle" type="button"
							id="notificationDropdown" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"
							style="background-color: white; color: #a35400; border: 1px solid #a35400; border-radius: 12px; padding: 6px 18px;">

							🔔 알림

							<c:if test="${notificationCount gt 0}">
								<span class="badge badge-danger ml-1">
									${notificationCount} </span>
							</c:if>

						</button>

						<div class="dropdown-menu dropdown-menu-right p-2"
							aria-labelledby="notificationDropdown"
							style="width: 340px; max-height: 420px; overflow-y: auto; border-radius: 14px;">

							<c:if test="${empty recentNotifications}">

								<div class="text-center text-muted p-3">알림이 없습니다.</div>

							</c:if>

							<c:forEach items="${recentNotifications}" var="dto">

								<a class="dropdown-item mb-2"
									href="/notification/read?notificationNum=${dto.notificationNum}&url=${dto.notificationUrl}"
									style="
				border-radius: 12px;
				padding: 12px;
				background-color:
				${dto.isRead ? '#f7f3ef' : '#fff8f1'};
				border:
				1px solid
				${dto.isRead ? '#e5ded8' : '#ffcfaa'};
				white-space: normal;">

									<div style="font-size: 14px; color: #3f2d20;">

										${dto.notificationContents}

										<c:if test="${!dto.isRead}">
											<span class="badge badge-warning ml-1"> NEW </span>
										</c:if>

									</div>

									<div style="font-size: 12px; color: #999; margin-top: 6px;">

										${dto.formatDate}</div>

								</a>

							</c:forEach>

							<div class="dropdown-divider"></div>

							<a href="/notification/list"
								class="dropdown-item text-center font-weight-bold"
								style="color: #a35400;"> 전체 알림 보기 </a>

						</div>

					</div>

					<a href="/member/detail" class="btn btn-sm mr-2"
						style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;">
						회원정보 </a> <a href="/member/logout" class="btn btn-sm"
						style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;">
						로그아웃 </a>

				</div>

			</sec:authorize>

		</div>

	</div>

</nav>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>