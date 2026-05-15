<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알바 공고 등록</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.create-box {
	max-width: 760px;
	margin: 55px auto;
	background-color: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.page-title {
	font-weight: 800;
	color: #3f2d20;
	margin-bottom: 30px;
}

.btn-orange {
	background-color: #ff6f0f;
	color: white;
	border-radius: 10px;
	font-weight: 700;
}

.btn-orange:hover {
	background-color: #e85f00;
	color: white;
}

label {
	font-weight: 700;
	color: #4a3527;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="create-box">

		<h2 class="page-title">알바 공고 등록</h2>

		<form action="./create" method="post" enctype="multipart/form-data">

			<div class="form-group">
				<label>제목</label> <input type="text" name="jobTitle"
					class="form-control" placeholder="예: 주말 카페 알바 구합니다" required>
			</div>

			<div class="form-group">
				<label>카테고리</label> <select name="jobCategory" class="form-control"
					required>
					<option value="">선택</option>
					<option value="서빙">서빙</option>
					<option value="주방보조">주방보조/설거지</option>
					<option value="편의점">편의점</option>
					<option value="매장관리">매장관리/판매</option>
					<option value="음료 제조">음료 제조</option>
					<option value="베이킹">베이킹</option>
					<option value="집옮기기">집 옮기기</option>
					<option value="청소">업체청소</option>
					<option value="과외">학원/과외/레슨</option>
				</select>
			</div>

			<div class="form-group">
				<label>근무 유형</label> <select name="jobType" class="form-control"
					required>
					<option value="">선택</option>
					<option value="단기">단기</option>
					<option value="1개월 이상">1개월 이상</option>
				</select>
			</div>

			<div class="form-group">
				<label>근무 지역</label> <input type="text" name="jobLocation"
					class="form-control" placeholder="예: 서울 금천구 가산동" required>
			</div>

			<div class="form-group">
				<label>급여</label> <input type="text" name="jobPay"
					class="form-control" placeholder="예: 시급 12,000원 / 월급 200만원"
					required>
			</div>

			<div class="form-group">
				<label>근무 요일</label> <input type="text" name="jobWorkDay"
					class="form-control" placeholder="예: 월~금 / 주말 / 협의" required>
			</div>

			<div class="form-group">
				<label>근무 시간</label> <input type="text" name="jobWorkTime"
					class="form-control" placeholder="예: 14:00~19:00 / 시간 협의" required>
			</div>

			<div class="form-group">
				<label>대표 이미지</label> <input type="file" name="attach"
					class="form-control-file">
			</div>

			<div class="form-group">
				<label>상세 내용</label>
				<textarea name="jobContents" class="form-control" rows="8"
					placeholder="업무 내용, 지원 조건, 근무 환경 등을 입력하세요." required></textarea>
			</div>

			<div class="text-right mt-4">
				<a href="./list" class="btn btn-secondary">취소</a>
				<button type="submit" class="btn btn-orange">등록</button>
			</div>

		</form>
	</div>

</body>
</html>