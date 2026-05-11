<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="#">Navbar</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="#">
					Home
					<span class="sr-only">(current)</span>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">Link</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false"> Dropdown </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="#">Action</a>
					<a class="dropdown-item" href="#">Another action</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#">Something else here</a>
				</div>
			</li>
			<li class="nav-item">
				<a class="nav-link disabled">Disabled</a>
			</li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<c:if test="${empty member}">
				<li class="nav-item">
					<a class="nav-link" href="/member/login">
						<i class="bi bi-box-arrow-in-right"></i>
						로그인
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/member/signUp">
						<i class="bi bi-person-plus"></i>
						회원가입
					</a>
				</li>
			</c:if>
			<c:if test="${not empty member}">
				<li class="nav-item">
					<a class="nav-link" href="/member/logout">
						<i class="bi bi-box-arrow-right"></i>
						로그아웃
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/member/detail">
						<i class="bi bi-person-circle"></i>
						회원정보
					</a>
				</li>
			</c:if>
		</ul>
	</div>
</nav>