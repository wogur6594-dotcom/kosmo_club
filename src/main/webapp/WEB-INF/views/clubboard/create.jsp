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

</head>
<body id="page-top">

	<div id="wrapper">

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<div class="container-fluid">

					<h1 class="h3 mb-4 text-gray-800">동호회 게시물등록</h1>

					<form method="post" enctype="multipart/form-data">

						<div class="form-group">
							<label>제목</label>
							<input type="text" name="boardTitle" class="form-control">
						</div>

						<div class="form-group">
							<label for="boardCategory">카테고리</label>
							<select name="boardCategory" id="boardCategory" class="form-control">
								<option value="자유">자유</option>
								<option value="일정">일정</option>
								<option value="공지">공지</option>
								<option value="후기">후기</option>
							</select>
						</div>

						<div class="form-group">
							<label>내용</label>
							<textarea name="boardContents" id="summernote"></textarea>
						</div>

						<div class="form-group">
							<label>파일 업로드</label>
							<input type="file" name="attaches" multiple class="form-control">
						</div>

						<button type="submit" class="btn btn-primary">등록</button>

					</form>

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
				['style', ['bold', 'italic', 'underline', 'clear']],
				['font', ['fontsize']],
				['color', ['color']],
				['para', ['ul', 'ol', 'paragraph']],
				['insert', ['picture', 'link']],
				['view', ['codeview']]
			]
		});
	</script>

</body>
</html>