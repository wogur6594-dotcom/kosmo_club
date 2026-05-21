<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류가 발생했습니다</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/error.css">
</head>

<body>

	<div class="error-box">

		<div class="error-code">500</div>

		<h1 class="error-title">오류가 발생했습니다</h1>

		<p class="error-text">
			서비스 이용 중 문제가 발생했습니다.<br> 잠시 후 다시 시도해주세요.
		</p>

		<div class="error-btn-area">

			<a href="/" class="btn-home"> 메인으로 이동 </a> <a
				href="javascript:history.back()" class="btn-back"> 이전 페이지 </a>

		</div>

	</div>

</body>
</html>