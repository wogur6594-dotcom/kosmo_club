<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	<form:form modelAttribute="update" action="./update" method="post" enctype="multipart/form-data" id="form">
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">이름</span>
			</div>
			<input type="text" class="form-control" name="memberName" value="${update.memberName}" readonly>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">ID</span>
			</div>
			<input type="text" class="form-control" name="memberId" value="${update.memberId}" readonly>
		</div>
		<form:errors path="memberPhone" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">Phone</span>
			</div>
			<input type="text" class="form-control" name="memberPhone" placeholder="ex) 01012341234" value="${update.memberPhone}">
		</div>
		<form:errors path="memberEmail" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">email</span>
			</div>
			<input type="email" class="form-control" name="memberEmail" value="${update.memberEmail}" id="uEmail">
			<button type="button" id="emailBtn">중복확인</button>
		</div>
		<div id="emailMsg" style="font-size: 12px; margin-top: 5px;"></div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">생년월일</span>
			</div>
			<input type="date" class="form-control" name="memberBirth" value="${update.memberBirth}" readonly>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">프로필 사진</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="attach" accept="image/*" id="uAttach">
				<label class="custom-file-label" id="uSelectFile"> ${not empty update.profile.oriName ? update.profile.oriName : "사진 선택"} </label>
			</div>
			<button type="button" id="deleteImgBtn" class="btn btn-outline-danger btn-sm">삭제</button>
		</div>
		<input type="hidden" name="deleteProfile" id="deleteProfile" value="false">
		<button type="submit" class="btn btn-outline-dark">정보수정</button>
	</form:form>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/update/update.js"></script>
</body>
</html>