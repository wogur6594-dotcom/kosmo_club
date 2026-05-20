<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>로그인 - 당근 느낌</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-light-orange: #fff1eb;
    }
    body {
        background-color: #f8f9fa;
    }
    .login-container {
        max-width: 400px;
        margin: 80px auto;
        padding: 40px;
        background: white;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    .login-logo {
        text-align: center;
        margin-bottom: 30px;
        font-weight: bold;
        font-size: 28px;
        color: var(--daangn-orange);
    }
    .form-control {
        border-radius: 8px;
        padding: 12px 15px;
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
        width: 100%;
        font-size: 16px;
        margin-top: 10px;
    }
    .btn-orange:hover {
        background-color: #e67831;
        color: white;
    }
    .auth-links {
        text-align: center;
        margin-top: 20px;
        font-size: 14px;
    }
    .auth-links a {
        color: #6c757d;
        text-decoration: none;
    }
    .auth-links a:hover {
        color: var(--daangn-orange);
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="login-container">
        <div class="login-logo">KOSMO CLUB</div>
        
        <form action="./login" method="post" id="loginForm">
            <div class="form-group mb-3">
                <label class="small font-weight-bold text-muted">아이디</label>
                <input type="text" class="form-control" name="memberId" placeholder="아이디를 입력해주세요">
            </div>
            
            <div class="form-group mb-4">
                <label class="small font-weight-bold text-muted">비밀번호</label>
                <input type="password" class="form-control" name="memberPw" placeholder="비밀번호를 입력해주세요">
            </div>

            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="saveId">
                    <label class="custom-control-label small text-muted" for="saveId">아이디 저장</label>
                </div>
                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" name="remember-me" id="rememberMe">
                    <label class="custom-control-label small text-muted" for="rememberMe">자동 로그인</label>
                </div>
            </div>

            <button type="submit" class="btn btn-orange">로그인</button>
        </form>

        <div class="auth-links">
            <a href="/member/signUp">아직 회원이 아니신가요? <span class="font-weight-bold ml-1">회원가입</span></a>
        </div>

        <c:if test="${not empty param.message}">
            <div class="alert alert-danger mt-3 small p-2 text-center">${param.message}</div>
        </c:if>
	</div>

    <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
	<c:remove var="loginError" scope="session" />
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script src="/js/login/login.js"></script>
</body>
</html>