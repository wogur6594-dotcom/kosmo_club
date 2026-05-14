<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 수정</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.schedule-form-box {
	max-width: 760px;
	margin: 60px auto;
	background-color: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.06);
}

.section-title {
	font-weight: 700;
	color: #3f2d20;
}

label {
	font-weight: 700;
	color: #5f4b3b;
}

.btn-brown {
	background-color: #b36200;
	color: white;
	border-radius: 12px;
	padding: 8px 18px;
	border: none;
}

.btn-brown:hover {
	color: white;
	background-color: #9d5600;
}

.btn-gray {
	background-color: #8c7b6d;
	color: white;
	border-radius: 12px;
	padding: 8px 18px;
}

.btn-gray:hover {
	color: white;
	background-color: #77685d;
}
</style>
</head>

<body>

	<div class="schedule-form-box">

		<h3 class="section-title mb-4">일정 수정</h3>

		<form action="./update" method="post">

			<input type="hidden" name="scheduleNum" value="${dto.scheduleNum}">
			<input type="hidden" name="clubNum" value="${dto.clubNum}">

			<div class="form-group">
				<label>일정 제목</label>
				<input type="text" name="scheduleTitle" class="form-control"
					value="${dto.scheduleTitle}" required>
			</div>

			<div class="form-group">
				<label>장소</label>
				<input type="text" name="scheduleLocation" class="form-control"
					value="${dto.scheduleLocation}" required>
			</div>

			<div class="form-group">
				<label>시작 시간</label>
				<input type="datetime-local" name="scheduleStart"
					class="form-control"
					value="${fn:substring(dto.scheduleStart.toString(), 0, 16)}"
					required>
			</div>

			<div class="form-group">
				<label>종료 시간</label>
				<input type="datetime-local" name="scheduleEnd"
					class="form-control"
					value="${fn:substring(dto.scheduleEnd.toString(), 0, 16)}">
			</div>

			<div class="form-group">
				<label>모집 인원</label>
				<input type="number" name="scheduleMax" class="form-control"
					value="${dto.scheduleMax}" min="1" required>
			</div>

			<div class="form-group">
				<label>내용</label>
				<textarea name="scheduleContents" class="form-control" rows="8"
					required>${dto.scheduleContents}</textarea>
			</div>

			<div class="d-flex justify-content-between mt-4">

				<a href="./detail?scheduleNum=${dto.scheduleNum}" class="btn btn-gray">
					취소
				</a>

				<button type="submit" class="btn btn-brown">
					수정 완료
				</button>

			</div>

		</form>

	</div>

</body>
</html>