<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>정보 수정</title>
<style>
:root {
	--daangn-orange: #ff8a3d;
	--daangn-grey: #868e96;
}

body {
	background-color: #f8f9fa;
}

.update-container {
	max-width: 500px;
	margin: 60px auto;
	background: white;
	border-radius: 16px;
	padding: 40px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.update-title {
	font-size: 22px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 30px;
}

.profile-edit-section {
	text-align: center;
	margin-bottom: 30px;
	position: relative;
}

.profile-preview {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	object-fit: cover;
	border: 2px solid #eee;
}

.form-group label {
	font-weight: bold;
	color: #495057;
	font-size: 14px;
	margin-bottom: 8px;
}

.form-control {
	border-radius: 8px;
	padding: 10px 15px;
	border: 1px solid #dee2e6;
}

.form-control:focus {
	border-color: var(--daangn-orange);
	box-shadow: 0 0 0 0.2rem rgba(255, 138, 61, 0.2);
}

.btn-orange {
	background-color: var(--daangn-orange);
	color: white;
	border: none;
	font-weight: bold;
	padding: 12px;
	border-radius: 8px;
}

.btn-orange:hover {
	background-color: #e67831;
	color: white;
}

.btn-password-change {
	display: block;
	width: 100%;
	margin-top: 12px;
	margin-bottom: 12px;
	padding: 12px 0;
	border: 1px solid #ff8a3d;
	border-radius: 10px;
	background-color: white;
	color: #ff8a3d;
	font-weight: 700;
	text-align: center;
	text-decoration: none;
	transition: 0.2s;
}

.btn-password-change:hover {
	background-color: #fff4ec;
	color: #ff8a3d;
	text-decoration: none;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="update-container">
		<h2 class="update-title">프로필 수정</h2>

		<div class="profile-edit-section">
			<c:choose>
				<c:when test="${not empty update.profile.fileName}">
					<c:choose>
						<c:when test="${fn:startsWith(update.profile.fileName, 'http')}">
							<img src="${update.profile.fileName}" class="profile-preview" id="previewImg">
						</c:when>
						<c:otherwise>
							<img src="/files/memberProfile/${update.profile.fileName}" class="profile-preview" id="previewImg">
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<img src="/image/default.png" class="profile-preview"
						id="previewImg">
				</c:otherwise>
			</c:choose>
			<div class="mt-2">
				<button type="button" id="deleteImgBtn"
					class="btn btn-sm btn-link text-danger">사진 삭제</button>
			</div>
		</div>

		<form:form modelAttribute="update" action="./update" method="post"
			enctype="multipart/form-data" id="form">
			<div class="form-group mb-3">
				<label>이름</label> <input type="text" class="form-control bg-light"
					name="memberName" value="${update.memberName}" readonly>
			</div>

			<div class="form-group mb-3">
				<label>아이디</label> <input type="text" class="form-control bg-light"
					name="memberId" value="${update.memberId}" readonly>
			</div>

			<div class="form-group mb-3">
				<label>전화번호</label>
				<div class="input-group">
					<input type="text" class="form-control" name="memberPhone"
						placeholder="01012341234" value="${update.memberPhone}"
						id="uPhone">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary btn-sm" type="button"
							id="phoneBtn">중복확인</button>
					</div>
				</div>
				<div id="phoneMsg" class="small mt-1"></div>
				<form:errors path="memberPhone" cssClass="text-danger small mt-1" />
			</div>

			<div class="form-group mb-3">
				<label>이메일</label>
				<div class="input-group">
					<input type="email" class="form-control" name="memberEmail"
						value="${update.memberEmail}" id="uEmail">
					<div class="input-group-append">
						<button class="btn btn-outline-secondary btn-sm" type="button"
							id="emailBtn">중복확인</button>
					</div>
				</div>
				<div id="emailMsg" class="small mt-1"></div>
				<form:errors path="memberEmail" cssClass="text-danger small mt-1" />
			</div>

			<div class="form-group mb-3">
				<label>생년월일</label> <input type="date" class="form-control bg-light"
					name="memberBirth" value="${update.memberBirth}" readonly>
			</div>

			<div class="form-group mb-4">
				<label>프로필 사진 변경</label>
				<div class="custom-file">
					<input type="file" class="custom-file-input" name="attach"
						accept="image/*" id="uAttach"> <label
						class="custom-file-label" id="uSelectFile"> ${not empty update.profile.oriName ? update.profile.oriName : "새 사진 선택"}
					</label>
				</div>
			</div>

			<input type="hidden" name="deleteProfile" id="deleteProfile"
				value="false">
			<a href="/member/pwChange" class="btn-password-change"> 비밀번호 변경 </a>

			<button type="submit" class="btn btn-orange btn-block">수정 완료</button>
			<a href="/member/detail"
				class="btn btn-link btn-block text-muted small">취소</a>
		</form:form>
	</div>

	<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/update/update.js"></script>
</body>
</html>