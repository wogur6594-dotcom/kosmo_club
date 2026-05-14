<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 등록</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #f8f5f1;
}

.schedule-form-box {
	max-width: 720px;
	margin: 60px auto;
	background-color: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
}

.form-title {
	font-weight: 700;
	color: #5a3e2b;
	margin-bottom: 30px;
}

.btn-brown {
	background-color: #8b5e3c;
	color: white;
	border-radius: 12px;
	padding: 8px 22px;
}

.btn-brown:hover {
	background-color: #70492d;
	color: white;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container">

		<div class="schedule-form-box">

			<h3 class="form-title">일정 등록</h3>

			<form action="./create" method="post">

				<input type="hidden" name="clubNum" value="${clubNum}">

				<div class="form-group">
					<label>일정 제목</label> <input type="text" name="scheduleTitle"
						class="form-control" required>
				</div>

				<div class="form-group">
					<label>일정 내용</label>
					<textarea name="scheduleContents" class="form-control" rows="5"></textarea>
				</div>

				<div class="form-group">
					<label>장소</label> <input type="text" name="scheduleLocation"
						class="form-control">
				</div>

				<div class="form-group">
					<label>시작 시간</label> <input type="datetime-local"
						name="scheduleStart" class="form-control" required>
				</div>

				<div class="form-group">
					<label>종료 시간</label> <input type="datetime-local"
						name="scheduleEnd" class="form-control">
				</div>

				<div class="form-group">
					<label>모집 인원</label> <input type="number" name="scheduleMax"
						class="form-control" min="1" required>
				</div>

				<div class="text-right mt-4">
					<a href="../club/detail?clubNum=${clubNum}"
						class="btn btn-secondary"> 취소 </a>

					<button type="submit" class="btn btn-brown">등록</button>
				</div>

			</form>

		</div>

	</div>

</body>
</html>