<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>회원가입 - 당근 느낌</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
    }
    body {
        background-color: #f8f9fa;
    }
    .signup-container {
        max-width: 500px;
        margin: 60px auto;
        padding: 40px;
        background: white;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    .signup-title {
        text-align: center;
        margin-bottom: 30px;
        font-weight: bold;
        font-size: 24px;
        color: #212529;
    }
    .form-control {
        border-radius: 8px;
        padding: 10px 15px;
        border: 1px solid #dee2e6;
        height: auto;
    }
    .form-control:focus {
        border-color: var(--daangn-orange);
        box-shadow: 0 0 0 0.2rem rgba(255, 138, 61, 0.25);
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
    .btn-check {
        background-color: #e9ecef;
        border: none;
        color: #495057;
        font-size: 13px;
        border-radius: 6px;
        padding: 0 15px;
    }
    .error-msg {
        color: #fa5252;
        font-size: 12px;
        margin-top: 4px;
        display: block;
    }
    .status-msg {
        font-size: 12px;
        margin-bottom: 10px;
        display: block;
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="signup-container">
        <h2 class="signup-title">회원가입</h2>
        
        <form:form modelAttribute="memberDTO" action="./signUp" method="post" enctype="multipart/form-data" id="form">
            <div class="form-group mb-3">
                <label class="small font-weight-bold text-muted">이름</label>
                <input type="text" class="form-control" name="memberName" placeholder="실명을 입력해주세요">
                <form:errors path="memberName" cssClass="error-msg" />
            </div>

            <div class="form-group mb-3">
                <label class="small font-weight-bold text-muted">아이디</label>
                <div class="input-group">
                    <input type="text" class="form-control" name="memberId" id="memberId" placeholder="아이디 입력">
                    <div class="input-group-append">
                        <button class="btn btn-check" type="button" id="checkBtn">중복확인</button>
                    </div>
                </div>
                <span id="idStatus" class="status-msg"></span>
                <form:errors path="memberId" cssClass="error-msg" />
            </div>

            <div class="form-group mb-3">
                <label class="small font-weight-bold text-muted">비밀번호</label>
                <input type="password" class="form-control" name="memberPw" id="pw" placeholder="비밀번호 (8자 이상)">
                <form:errors path="memberPw" cssClass="error-msg" />
            </div>

            <div class="form-group mb-3 d-none" id="pwInputBox">
                <label class="small font-weight-bold text-muted">비밀번호 확인</label>
                <input type="password" class="form-control" id="pwCheck" placeholder="비밀번호 다시 입력">
                <span id="pwStatus" class="status-msg"></span>
            </div>

            <div class="form-group mb-3">
                <label class="small font-weight-bold text-muted">전화번호</label>
                <div class="input-group">
                    <input type="text" id="memberPhone" name="memberPhone" class="form-control" placeholder="010-0000-0000">
                    <div class="input-group-append">
                        <button class="btn btn-check" type="button" id="phoneCheckBtn">중복확인</button>
                    </div>
                </div>
                <form:errors path="memberPhone" cssClass="error-msg" />
            </div>

            <div class="form-group mb-3">
                <label class="small font-weight-bold text-muted">이메일</label>
                <div class="input-group">
                    <input type="email" class="form-control" id="email" name="memberEmail" placeholder="example@naver.com">
                    <div class="input-group-append">
                        <button class="btn btn-check" type="button" id="emailCheckBtn">중복확인</button>
                    </div>
                </div>
                <span id="emailStatus" class="status-msg"></span>
                <form:errors path="memberEmail" cssClass="error-msg" />
            </div>

            <div class="form-group mb-3">
                <label class="small font-weight-bold text-muted">생년월일</label>
                <input type="date" class="form-control" name="memberBirth">
                <form:errors path="memberBirth" cssClass="error-msg" />
            </div>

            <div class="form-group mb-4">
                <label class="small font-weight-bold text-muted">프로필 사진</label>
                <div class="custom-file">
                    <input type="file" class="custom-file-input" name="attach" id="attach" accept="image/*">
                    <label class="custom-file-label" for="attach" id="selectFile">사진 선택하기</label>
                </div>
                <div class="mt-2 text-right" style="display: none" id="fileDiv">
                    <button type="button" class="btn btn-sm btn-link text-danger" id="deleteFileBtn">사진 삭제</button>
                </div>
            </div>

            <button type="submit" class="btn btn-orange btn-block mt-4">가입하기</button>
        </form:form>
	</div>

    <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/signUp/signUp.js"></script>
</body>
</html>