<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동호회 게시물등록</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-bs4.min.css">

<style>
body {
	background-color: #fff8f2;
	color: #2d2118;
}

.create-wrap {
	max-width: 920px;
	margin: 50px auto 80px;
	padding: 0 20px;
}

.create-card {
	background-color: white;
	border-radius: 26px;
	padding: 42px;
	box-shadow: 0 8px 24px rgba(120, 80, 40, 0.08);
	border: 1px solid #f1dfd0;
}

.create-header {
	margin-bottom: 30px;
}

.create-badge {
	display: inline-block;
	background-color: #ffe2c4;
	color: #b45f00;
	font-weight: 800;
	border-radius: 999px;
	padding: 7px 16px;
	margin-bottom: 14px;
}

.create-header h1 {
	font-size: 30px;
	font-weight: 900;
	color: #2d2118;
	margin-bottom: 8px;
}

.create-header p {
	color: #7a6657;
	margin-bottom: 0;
}

.form-group {
	margin-bottom: 24px;
}

.form-group label {
	font-weight: 800;
	color: #3f2d20;
	margin-bottom: 8px;
}

.form-control {
	border-radius: 12px;
	border: 1px solid #e0d1c2;
	padding: 10px 14px;
	color: #2d2118;
}

.form-control:focus {
	border-color: #ff9b42;
	box-shadow: 0 0 0 0.2rem rgba(255, 122, 0, 0.15);
}

.note-editor {
	border-radius: 14px;
	overflow: hidden;
	border-color: #e0d1c2 !important;
}

.note-toolbar {
	background-color: #fff3e8 !important;
	border-bottom: 1px solid #ead1bb !important;
}

.note-editable {
	min-height: 300px;
	color: #2d2118;
}

.file-help {
	font-size: 13px;
	color: #8a7565;
	margin-top: 6px;
}

.btn-area {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
	margin-top: 30px;
}

.btn-brown {
	background-color: #a35400;
	color: white;
	border-radius: 12px;
	padding: 10px 26px;
	font-weight: 800;
	border: none;
}

.btn-brown:hover {
	background-color: #8b4700;
	color: white;
}

.btn-light-brown {
	background-color: #fff3e8;
	color: #8a4b12;
	border: 1px solid #ead1bb;
	border-radius: 12px;
	padding: 10px 24px;
	font-weight: 800;
}

.btn-light-brown:hover {
	background-color: #ffe5cc;
	color: #8a4b12;
}
</style>
</head>

<body id="page-top">

	<div id="wrapper">

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<div class="create-wrap">

					<div class="create-card">

						<div class="create-header">
							<span class="create-badge">Club Board</span>

							<h1>동호회 게시물 등록</h1>

							<p>동호회 회원들과 공유할 게시글을 작성해주세요.</p>
						</div>

						<form action="/clubboard/create" method="post"
							enctype="multipart/form-data">

							<input type="hidden" name="clubNum" value="${param.clubNum}">

							<div class="form-group">
								<label>제목</label>
								<input type="text" name="boardTitle" class="form-control"
									placeholder="제목을 입력하세요">
							</div>

							<div class="form-group">
								<label for="boardCategory">카테고리</label>

								<select name="boardCategory" id="boardCategory"
									class="form-control">

									<c:choose>
										<c:when test="${param.boardCategory eq '공지'}">
											<option value="공지" selected>공지</option>
										</c:when>

										<c:otherwise>
											<option value="자유">자유</option>
											<option value="일정">일정</option>
											<option value="후기">후기</option>
										</c:otherwise>
									</c:choose>

								</select>
							</div>

							<div class="form-group">
								<label>내용</label>
								<textarea name="boardContents" id="summernote"></textarea>
							</div>

							<div class="form-group">
								<label>파일 업로드</label>
								<input type="file" name="attaches" multiple class="form-control">
								<div class="file-help">
									여러 개의 파일을 선택할 수 있습니다.
								</div>
							</div>

							<div class="btn-area">
								<a href="${pageContext.request.contextPath}/club/detail?clubNum=${param.clubNum}"
									class="btn btn-light-brown">
									취소
								</a>

								<button type="submit" class="btn btn-brown">
									등록
								</button>
							</div>

						</form>

					</div>

				</div>

			</div>
		</div>

	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

	<script
		src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-bs4.min.js"></script>

	<script>
		$('#summernote').summernote({
			placeholder : '내용을 입력하세요',
			tabsize : 2,
			height : 300,
			toolbar : [
				[ 'style', [ 'bold', 'italic', 'underline', 'clear' ] ],
				[ 'font', [ 'fontsize' ] ],
				[ 'color', [ 'color' ] ],
				[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
				[ 'insert', [ 'picture', 'link' ] ],
				[ 'view', [ 'codeview' ] ]
			]
		});
	</script>

</body>
</html>