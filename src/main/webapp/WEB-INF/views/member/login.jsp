<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>Insert title here</title>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	<h1>로그인 페이지</h1>
	<form action="./login" method="post" id="loginForm">
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">ID</span>
			</div>
			<input type="text" class="form-control" name="memberId">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">PW</span>
			</div>
			<input type="password" class="form-control" name="memberPw">
		</div>
		<div class="mb-3">
			<div class="form-check form-check-inline me-4">
				<input type="checkbox" class="form-check-input" id="saveId">
				<label class="form-check-label" for="saveId">아이디 저장</label>
			</div>
			<div class="form-check form-check-inline">
				<input type="checkbox" class="form-check-input" name="remember-me" id="rememberMe">
				<label class="form-check-label" for="rememberMe">자동 로그인</label>
			</div>
		</div>
		<button type="submit" class="btn btn-outline-dark">로그인</button>
	</form>
	<div>
		<h3>${param.message}</h3>
	</div>
	<c:remove var="loginError" scope="session" />
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/login/login.js"></script>
</body>
</html>