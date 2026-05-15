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
	<h1>회원가입 페이지</h1>
	<form:form modelAttribute="memberDTO" action="./signUp" method="post" enctype="multipart/form-data" id="form">
		<form:errors path="memberName" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">이름</span>
			</div>
			<input type="text" class="form-control" name="memberName">
		</div>
		<form:errors path="memberId" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">ID</span>
			</div>
			<input type="text" class="form-control" name="memberId" id="memberId">
			<button type="button" id="checkBtn">중복확인</button>
		</div>
		<span id="idStatus"></span>
		<form:errors path="memberPw" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">Password</span>
			</div>
			<input type="password" class="form-control" name="memberPw" id="pw">
		</div>
		<div class="input-group mb-1 d-none" id="pwInputBox">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">Password Check</span>
			</div>
			<input type="password" class="form-control" id="pwCheck">
		</div>
		<span id="pwStatus"></span>
		<form:errors path="memberPhone" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">전화번호</span>
			</div>
			<input type="text" id="memberPhone" name="memberPhone" class="form-control">
			<button type="button" id="phoneCheckBtn">중복확인</button>
		</div>
		</div>
		<form:errors path="memberEmail" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">email</span>
			</div>
			<input type="email" class="form-control" id="email" name="memberEmail" placeholder="ex) example@naver.com">
			<button type="button" id="emailCheckBtn">중복확인</button>
		</div>
		<span id="emailStatus"></span>
		<form:errors path="memberBirth" cssStyle="color:red" />
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">Date</span>
			</div>
			<input type="date" class="form-control" name="memberBirth">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="inputGroupFileAddon01">프로필 사진</span>
			</div>
			<div class="custom-file">
				<input type="file" class="custom-file-input" name="attach" id="attach" accept="image/*">
				<label class="custom-file-label" for="attach" id="selectFile">사진 선택</label>
			</div>
			<div style="display: none" id="fileDiv">
				<button type="button" class="btn btn-outline-danger" id="deleteFileBtn">삭제</button>
			</div>
		</div>
		<button type="submit" class="btn btn-outline-dark">회원가입</button>

	</form:form>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/js/signUp/signUp.js"></script>
</body>
</html>