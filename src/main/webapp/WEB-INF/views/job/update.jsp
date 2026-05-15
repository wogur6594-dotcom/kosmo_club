<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알바 공고 수정</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.update-box {
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

	<div class="update-box">

		<h2 class="page-title">알바 공고 수정</h2>

		<form action="./update" method="post" enctype="multipart/form-data">

			<input type="hidden" name="jobNum" value="${dto.jobNum}">

			<div class="form-group">
				<label>제목</label> <input type="text" name="jobTitle"
					class="form-control" value="${dto.jobTitle}" required>
			</div>

			<div class="form-group">
				<label>카테고리</label> <select name="jobCategory" class="form-control"
					required>
					<option value="서빙" ${dto.jobCategory eq '서빙' ? 'selected' : ''}>서빙</option>
					<option value="주방보조" ${dto.jobCategory eq '주방보조' ? 'selected' : ''}>주방보조/설거지</option>
					<option value="편의점" ${dto.jobCategory eq '편의점' ? 'selected' : ''}>편의점</option>
					<option value="매장관리" ${dto.jobCategory eq '매장관리' ? 'selected' : ''}>매장관리/판매</option>
					<option value="음료 제조"
						${dto.jobCategory eq '음료 제조' ? 'selected' : ''}>음료 제조</option>
					<option value="베이킹" ${dto.jobCategory eq '베이킹' ? 'selected' : ''}>베이킹</option>
					<option value="집옮기기" ${dto.jobCategory eq '집옮기기' ? 'selected' : ''}>집
						옮기기</option>
					<option value="청소" ${dto.jobCategory eq '청소' ? 'selected' : ''}>업체청소</option>
					<option value="과외" ${dto.jobCategory eq '과외' ? 'selected' : ''}>학원/과외/레슨</option>
				</select>
			</div>

			<div class="form-group">
				<label>근무 유형</label> <select name="jobType" class="form-control"
					required>
					<option value="단기" ${dto.jobType eq '단기' ? 'selected' : ''}>단기</option>
					<option value="1개월 이상" ${dto.jobType eq '1개월 이상' ? 'selected' : ''}>1개월
						이상</option>
				</select>
			</div>

			<div class="form-group">
				<label>근무 지역</label> <input type="text" name="jobLocation"
					class="form-control" value="${dto.jobLocation}" required>
			</div>

			<div class="form-group">
				<label>급여</label> <input type="text" name="jobPay"
					class="form-control" value="${dto.jobPay}" required>
			</div>

			<div class="form-group">
				<label>근무 요일</label> <input type="text" name="jobWorkDay"
					class="form-control" value="${dto.jobWorkDay}" required>
			</div>

			<div class="form-group">
				<label>근무 시간</label> <input type="text" name="jobWorkTime"
					class="form-control" value="${dto.jobWorkTime}" required>
			</div>

			<c:if test="${not empty dto.fileName}">
				<div class="form-group">

					<label>현재 이미지</label>

					<div style="display: flex; align-items: flex-end; gap: 16px;">

						<div style="position: relative; width: 180px;">

							<img src="/files/job/${dto.fileName}"
								style="width: 180px; height: 180px; object-fit: cover; border-radius: 12px; border: 1px solid #ddd;">

							<button type="submit" form="deleteFileForm"
								class="btn btn-danger btn-sm"
								style="position: absolute; right: 8px; bottom: 8px; border-radius: 10px;">

								삭제</button>

						</div>

					</div>

				</div>
			</c:if>

			<div class="form-group">
				<label>대표 이미지 변경</label> <input type="file" name="attach"
					class="form-control-file">
			</div>

			<div class="form-group">
				<label>상세 내용</label>
				<textarea name="jobContents" class="form-control" rows="8" required>${dto.jobContents}</textarea>
			</div>

			<div class="text-right mt-4">
				<a href="./detail?jobNum=${dto.jobNum}" class="btn btn-secondary">취소</a>
				<button type="submit" class="btn btn-orange">수정</button>
			</div>

		</form>
		<c:if test="${not empty dto.fileName}">
			<form id="deleteFileForm" action="./deleteFile" method="post">
				<input type="hidden" name="jobNum" value="${dto.jobNum}">
			</form>
		</c:if>



	</div>

</body>
</html>