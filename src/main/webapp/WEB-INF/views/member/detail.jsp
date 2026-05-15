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
	<h1>회원정보 페이지</h1>
	<c:choose>
		<c:when test="${not empty detail.profile.fileName}">
			<img src="/files/memberProfile/${detail.profile.fileName}" class="img-thumbnail">
		</c:when>
		<c:otherwise>
			<img src="/image/default.png" class="img-thumbnail" style="width: 150px; height: 150px;">
		</c:otherwise>
	</c:choose>
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">이름</span>
		</div>
		<input type="text" class="form-control" name="memberName" value="${detail.memberName}" readonly>
	</div>
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">ID</span>
		</div>
		<input type="text" class="form-control" name="memberId" value="${detail.memberId}" readonly>
	</div>
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">비밀번호</span>
		</div>
		<input type="text" class="form-control" readonly>
		<a class="btn btn-outline-dark" href="/member/pwChange">비밀번호 변경</a>
	</div>
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">Phone</span>
		</div>
		<input type="text" class="form-control" name="memberPhone" value="${detail.memberPhone}" readonly>
	</div>
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">email</span>
		</div>
		<input type="email" class="form-control" name="memberEmail" value="${detail.memberEmail}" readonly>
	</div>
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text" id="basic-addon1">생년월일</span>
		</div>
		<input type="date" class="form-control" name="memberBirth" value="${detail.memberBirth}" readonly>
	</div>
	<a class="btn btn-outline-dark" href="/member/update">정보수정</a>
	<form action="/member/delete" method="post">
		<button type="submit" class="btn btn-outline-danger">회원삭제</button>
	</form>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script>
    const msg = "${msg}";
    if (msg) {
        alert(msg);
    }
</script>
</body>
</html>