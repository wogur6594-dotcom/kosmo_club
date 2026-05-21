<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>접근 권한이 없습니다</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/error.css">
</head>

<body>

	<div class="error-box">

		<div class="error-code">403</div>

		<h1 class="error-title">접근 권한이 없습니다</h1>

		<p class="error-text">
			이 페이지에 접근할 권한이 없습니다.<br> 로그인이 필요하거나 권한이 부족할 수 있습니다.
		</p>

		<div class="error-btn-area">

			<a href="/" class="btn-home"> 메인으로 이동 </a> <a href="/member/login"
				class="btn-back"> 로그인하기 </a>

		</div>

	</div>

</body>
</html>