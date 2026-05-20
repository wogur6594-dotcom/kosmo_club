<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 만들기</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #f8f5f1;
	color: #2b1b12;
}

.create-wrap {
	max-width: 760px;
	margin: 50px auto;
	padding: 0 20px;
}

.create-box {
	background-color: #fffaf5;
	border-radius: 24px;
	padding: 42px;
	box-shadow: 0 12px 30px rgba(163, 84, 0, 0.10);
	border: 1px solid #eadbd0;
}

.page-title {
	font-size: 30px;
	font-weight: 800;
	color: #8b4700;
	margin-bottom: 8px;
}

.page-desc {
	color: #6f5b4c;
	margin-bottom: 32px;
}

.form-group label {
	font-weight: 700;
	color: #3d2b1f;
	margin-bottom: 8px;
}

.form-control, .form-control-file {
	border-radius: 14px;
	border: 1px solid #dfd2c8;
	padding: 12px 14px;
	background-color: white;
	height: 54px;
	font-size: 16px;
	line-height: 1.5;
	color: #2b1b12;
}

.form-control:focus {
	border-color: #a35400;
	box-shadow: 0 0 0 0.15rem rgba(163, 84, 0, 0.18);
}

.btn-brown {
	background-color: #a35400;
	color: white;
	border: none;
	border-radius: 14px;
	padding: 11px 24px;
	font-weight: 700;
	transition: all 0.25s ease;
	box-shadow: 0 6px 16px rgba(163, 84, 0, 0.20);
}

.btn-brown:hover {
	background-color: #8b4700;
	color: white;
	text-decoration: none;
	transform: translateY(-1px);
}

.btn-soft-gray {
	background-color: #ebe3dc;
	color: #6f5b4c;
	border: none;
	border-radius: 14px;
	padding: 11px 24px;
	font-weight: 700;
	transition: all 0.25s ease;
}

.btn-soft-gray:hover {
	background-color: #ddd2c8;
	color: #4e4036;
	text-decoration: none;
	transform: translateY(-1px);
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="create-wrap">

		<div class="create-box">

			<h1 class="page-title">모임 만들기</h1>
			<p class="page-desc">새로운 동호회를 만들고 이웃들과 함께 활동을 시작해보세요.</p>

			<form action="./create" method="post" enctype="multipart/form-data">

				<div class="form-group">
					<label>동호회 이름</label> <input type="text" name="clubName"
						class="form-control" placeholder="예: 주말 자전거 라이딩팀">
				</div>

				<div class="form-group">
					<label>카테고리</label> <select name="clubCategory"
						class="form-control">
						<option value="운동">운동</option>
						<option value="맛집">맛집</option>
						<option value="여행">여행</option>
						<option value="음악">음악</option>
						<option value="스터디">스터디</option>
						<option value="기타">기타</option>
					</select>
				</div>

				<div class="form-group">
					<label>지역</label> <input type="text" name="clubLocation"
						class="form-control" placeholder="예: 서울, 대전, 부산">
				</div>

				<div class="form-group">
					<label>정원</label> <input type="number" name="clubMax"
						class="form-control" placeholder="예: 20">
				</div>

				<div class="form-group">
					<label>동호회 소개글</label>
					<textarea name="clubContents" class="form-control" rows="4"
						placeholder="동호회를 간단히 소개해주세요."></textarea>
				</div>

				<div class="form-group">
					<label>사진 업로드</label> <input type="file" name="attach"
						class="form-control-file">
				</div>

				<div class="d-flex justify-content-between align-items-center mt-4">

					<a href="./list" class="btn-soft-gray"> 뒤로 </a>

					<button type="submit" class="btn-brown">등록</button>

				</div>

			</form>

		</div>

	</div>

</body>
</html>