<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<title>내 프로필</title>

<style>
:root {
	--main-orange: #ff8a3d;
	--main-brown: #a35400;
	--light-bg: #fffaf0;
	--line: #f1f3f5;
	--grey: #868e96;
}

body {
	background-color: #f8f9fa;
}

.profile-container {
	max-width: 500px;
	margin: 60px auto;
	background: white;
	border-radius: 18px;
	box-shadow: 0 6px 24px rgba(0, 0, 0, 0.07);
	overflow: hidden;
}

.profile-header {
	padding: 42px 20px 38px;
	text-align: center;
	background: linear-gradient(to bottom, #fffaf0, #ffffff);
	border-bottom: 1px solid var(--line);
}

.profile-img {
	width: 118px;
	height: 118px;
	border-radius: 50%;
	object-fit: cover;
	border: 4px solid white;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.12);
	margin-bottom: 16px;
}

.profile-name {
	font-size: 21px;
	font-weight: 800;
	color: #212529;
}

.profile-id {
	margin-top: 3px;
	font-size: 14px;
	color: var(--grey);
}

.info-list {
	padding: 22px 28px 10px;
}

.info-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 16px 0;
	border-bottom: 1px solid #f3f3f3;
}

.info-item:last-child {
	border-bottom: none;
}

.info-label {
	font-weight: 600;
	color: var(--grey);
	font-size: 14px;
}

.info-value {
	font-weight: 700;
	color: #495057;
	font-size: 14px;
}

.profile-action-area {
	padding: 24px 28px 28px;
}

.btn-update {
	display: block;
	width: 100%;
	padding: 13px 0;
	border-radius: 12px;
	background-color: var(--main-orange);
	color: white;
	font-weight: 800;
	text-align: center;
	text-decoration: none;
}

.btn-update:hover {
	background-color: #e67831;
	color: white;
	text-decoration: none;
}

.sub-action-area {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 14px;
	margin-top: 16px;
}

.btn-mypage {
	padding: 8px 14px;
	border: 1px solid var(--main-brown);
	border-radius: 10px;
	color: var(--main-brown);
	background: white;
	font-size: 14px;
	font-weight: 700;
	text-decoration: none;
}

.btn-mypage:hover {
	background: #fff7f3;
	color: var(--main-brown);
	text-decoration: none;
}

.delete-form {
	margin: 0;
}

.btn-delete {
	border: none;
	background: none;
	padding: 0;
	color: #888;
	font-size: 14px;
	cursor: pointer;
}

.btn-delete:hover {
	color: var(--main-brown);
	text-decoration: underline;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="profile-container">

		<div class="profile-header">
			<c:choose>
				<c:when test="${not empty detail.profile.fileName}">
					<c:choose>
						<c:when test="${fn:startsWith(detail.profile.fileName, 'http')}">
							<img src="${detail.profile.fileName}" class="profile-img">
						</c:when>
						<c:otherwise>
							<img src="/files/memberProfile/${detail.profile.fileName}" class="profile-img">
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<img src="/image/default.png" class="profile-img">
				</c:otherwise>
			</c:choose>

			<div class="profile-name">${detail.memberName}</div>
			<div class="profile-id">@${detail.memberId}</div>
		</div>

		<div class="info-list">
			<div class="info-item">
				<span class="info-label">전화번호</span> <span class="info-value">${detail.memberPhone}</span>
			</div>

			<div class="info-item">
				<span class="info-label">이메일</span> <span class="info-value">${detail.memberEmail}</span>
			</div>

			<div class="info-item">
				<span class="info-label">생년월일</span> <span class="info-value">${detail.memberBirth}</span>
			</div>
		</div>

		<div class="profile-action-area">
			<a href="/member/update" class="btn-update">회원정보수정</a>

			<div class="sub-action-area">
				<a href="/member/mypage" class="btn-mypage">마이페이지</a>

				<form action="/member/delete" method="post" class="delete-form"
					onsubmit="return confirm('정말 탈퇴하시겠습니까?');">
					<button type="submit" class="btn-delete">회원 탈퇴</button>
				</form>
			</div>
		</div>

	</div>

	<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>

	<script>
		const msg = "${msg}";
		if (msg) {
			alert(msg);
		}
	</script>

</body>
</html>