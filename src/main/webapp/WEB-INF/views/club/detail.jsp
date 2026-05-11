<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

</head>
<body>

	<div class="container mt-5">

		<h1>${dto.clubName}</a>
		</h1>

		<hr>

		<p>카테고리 : ${dto.clubCategory}</p>

		<p>지역 : ${dto.clubLocation}</p>

		<p>정원 : ${dto.clubMax}</p>

		<a href="./list?page=${param.page}">뒤로가기 
	</div>


</body>
</html>