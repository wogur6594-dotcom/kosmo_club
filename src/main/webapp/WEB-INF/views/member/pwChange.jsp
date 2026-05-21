<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>비밀번호 변경</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-grey: #868e96;
    }
    body {
        background-color: #f8f9fa;
    }
    .pw-container {
        max-width: 400px;
        margin: 60px auto;
        padding: 40px;
        background: white;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    .pw-title {
        font-weight: bold;
        font-size: 24px;
        text-align: center;
        margin-bottom: 30px;
        color: #212529;
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
        height: auto;
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
        font-size: 16px;
    }
    .btn-orange:hover {
        background-color: #e67831;
        color: white;
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="pw-container">
        <h2 class="pw-title">비밀번호 변경</h2>
        
        <form:form modelAttribute="memberDTO" action="./pwChange" method="post" enctype="multipart/form-data" id="form">
            <div class="form-group mb-3">
                <label>현재 비밀번호</label>
                <input type="password" class="form-control" id="pw" placeholder="현재 비밀번호 입력">
            </div>
            
            <div class="form-group mb-3">
                <label>새 비밀번호</label>
                <input type="password" class="form-control" name="memberPw" id="newPw" placeholder="새 비밀번호 입력">
                <small class="text-muted d-block mt-1">8~16자 영문, 숫자, 특수문자(@,$,!,%,*,#,?,&)를 포함해야 합니다.</small>
                <form:errors path="memberPw" cssClass="text-danger small mt-1" />
            </div>
            
            <div class="form-group mb-4">
                <label>비밀번호 확인</label>
                <input type="password" class="form-control" id="newPwCheck" placeholder="새 비밀번호 다시 입력">
            </div>

            <button type="submit" class="btn btn-orange btn-block">비밀번호 변경하기</button>
            <a href="/member/detail" class="btn btn-link btn-block text-muted small mt-2">취소</a>
        </form:form>
	</div>
	
    <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/update/pwChange.js"></script>
</body>
</html>