<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #fff7f3; border-bottom: 1px solid #d8cfc8;">
	<div class="container">
		<a class="navbar-brand font-weight-bold" href="/" style="color: #a35400; font-size: 32px;"> Kosmo Project </a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">

			<span class="navbar-toggler-icon"></span>

		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-5">
				<li class="nav-item mr-4">
					<a class="nav-link font-weight-bold" href="/product/list" style="color: #5a3d2b;"> 중고거래 </a>
				</li>
				<li class="nav-item mr-4">
					<a class="nav-link font-weight-bold" href="/club/list" style="color: #a35400; border-bottom: 2px solid #a35400;"> 동호회 </a>
				</li>
				<li class="nav-item mr-4">
					<a class="nav-link font-weight-bold" href="#" style="color: #5a3d2b;"> ???? </a>
				</li>
				<li class="nav-item">
					<a class="nav-link font-weight-bold" href="/job/list" style="color: #5a3d2b;"> 동네알바 </a>
				</li>
			</ul>
			<sec:authorize access="!isAuthenticated()">
			<div class="ml-auto">
				<a href="/member/signUp" class="btn btn-sm mr-2" style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;"> 회원가입 </a>
				<a href="/member/login" class="btn btn-sm" style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;"> 로그인 </a>
			</div>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<div class="ml-auto">
					<a href="/member/detail" class="btn btn-sm mr-2" style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;"> 회원정보 </a>
					<a href="/member/logout" class="btn btn-sm" style="background-color: #a35400; color: white; border-radius: 12px; padding: 6px 18px;"> 로그아웃 </a>
				</div>
			</sec:authorize>
		</div>
	</div>
</nav>