<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>내 프로필 - 당근 느낌</title>
<style>
    :root {
        --daangn-orange: #ff8a3d;
        --daangn-light-grey: #f1f3f5;
        --daangn-grey: #868e96;
    }
    body {
        background-color: #f8f9fa;
    }
    .profile-container {
        max-width: 500px;
        margin: 60px auto;
        background: white;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.06);
        overflow: hidden;
    }
    .profile-header {
        padding: 40px 20px;
        text-align: center;
        background: linear-gradient(to bottom, #fffaf0, #ffffff);
        border-bottom: 1px solid var(--daangn-light-grey);
    }
    .profile-img {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid white;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 15px;
    }
    .profile-name {
        font-size: 20px;
        font-weight: bold;
        color: #212529;
    }
    .profile-id {
        font-size: 14px;
        color: var(--daangn-grey);
    }
    
    .info-list {
        padding: 20px;
    }
    .info-item {
        display: flex;
        justify-content: space-between;
        padding: 15px 10px;
        border-bottom: 1px solid #f8f9fa;
    }
    .info-item:last-child {
        border-bottom: none;
    }
    .info-label {
        font-weight: 500;
        color: var(--daangn-grey);
        font-size: 14px;
    }
    .info-value {
        font-weight: 600;
        color: #495057;
        font-size: 14px;
    }
    
    .action-area {
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 10px;
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
    .btn-outline-orange {
        border: 1px solid var(--daangn-orange);
        color: var(--daangn-orange);
        background: white;
        font-weight: bold;
        padding: 12px;
        border-radius: 8px;
    }
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>
	
	<div class="profile-container">
        <div class="profile-header">
            <c:choose>
                <c:when test="${not empty detail.profile.fileName}">
                    <img src="/files/memberProfile/${detail.profile.fileName}" class="profile-img">
                </c:when>
                <c:otherwise>
                    <img src="/image/default.png" class="profile-img">
                </c:otherwise>
            </c:choose>
            <div class="profile-name">${detail.memberName}</div>
            <div class="profile-id">@${detail.memberId}</div>
        </div>
        
        <div class="info-list">
            <div class="info-item">
                <span class="info-label">전화번호</span>
                <span class="info-value">${detail.memberPhone}</span>
            </div>
            <div class="info-item">
                <span class="info-label">이메일</span>
                <span class="info-value">${detail.memberEmail}</span>
            </div>
            <div class="info-item">
                <span class="info-label">생년월일</span>
                <span class="info-value">${detail.memberBirth}</span>
            </div>
        </div>

        <div class="action-area">
            <a class="btn btn-orange" href="/member/update">회원 정보 수정</a>
            <a class="btn btn-outline-orange text-center" href="/member/pwChange">비밀번호 변경</a>
            
            <form action="/member/delete" method="post" class="mt-2">
                <button type="submit" class="btn btn-link btn-sm btn-block text-muted" onclick="return confirm('정말 탈퇴하시겠습니까?')">회원 탈퇴</button>
            </form>
        </div>
	</div>

    <c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script>
        const msg = "${msg}";
        if (msg) alert(msg);
    </script>
</body>
</html>