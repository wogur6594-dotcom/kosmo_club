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

<link rel="stylesheet" href="/css/common.css">
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