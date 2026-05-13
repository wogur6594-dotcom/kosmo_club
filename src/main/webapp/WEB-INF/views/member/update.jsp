<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>회원가입</title>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	<h1>회원정보 수정 페이지</h1>
	<c:choose>
		<c:when test="${not empty update.profile.fileName}">
			<img src="/files/memberProfile/${update.profile.fileName}" class="img-thumbnail">
		</c:when>
		<c:otherwise>
			<img src="/image/default.png" class="img-thumbnail" style="width: 150px; height: 150px;">
		</c:otherwise>
	</c:choose>
	<form action="./update" method="post" enctype="multipart/form-data">
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">이름</span>
			</div>
			<input type="text" class="form-control" name="memberName" value="${update.memberName}">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">ID</span>
			</div>
			<input type="text" class="form-control" name="memberId" value="${update.memberId}">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">Phone</span>
			</div>
			<input type="text" class="form-control" name="memberPhone" placeholder="ex) 01012341234" value="${update.memberPhone}">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">email</span>
			</div>
			<input type="email" class="form-control" name="memberEmail" value="${update.memberEmail}">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">생년월일</span>
			</div>
			<input type="date" class="form-control" name="memberBirth" value="${update.memberBirth}" readonly>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputGroupFileAddon01">프로필 사진</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="attach">
				<label class="custom-file-label" for="attach">사진 선택</label>
			</div>
		</div>
		<button type="submit" class="btn btn-outline-dark">정보수정</button>
	</form>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>