<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	<h1>비밀번호 변경</h1>
	<form:form modelAttribute="memberDTO" action="./pwChange" method="post" enctype="multipart/form-data" id="form">
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">현재 비밀번호</span>
			</div>
			<input type="password" class="form-control" id="pw">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">변경할 비밀번호</span>
			</div>
			<input type="password" class="form-control" name="memberPw" id="newPw">
		</div>
		<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">비밀번호 확인</span>
		</div>
		<input type="password" class="form-control" id="newPwCheck">
	</div>
	<button type="submit" class="btn btn-outline-dark">비밀번호 변경</button>
	</form:form>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/update/pwChange.js"></script>
</body>
</html>