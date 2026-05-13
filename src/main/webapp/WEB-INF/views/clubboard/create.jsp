<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css"
	rel="stylesheet">


</head>
<body id="page-top">
	<div id="wrapper">

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-4 text-gray-800">동호회 게시물등록</h1>

					<div>
						<form method="post" enctype="multipart/form-data">

							<div class="form-group">
							<!-- 제목 -->
								<label>제목</label> <input type="text" name="boardTitle"
									class="form-control">
							</div>
							
							<!-- 카테고리 -->
							<div class="form-group">
								<label for="boardCategory">카테고리</label> <select
									name="boardCategory" id="boardCategory" class="form-control">
									<option value="자유">자유</option>
									<option value="일정">일정</option>
									<option value="공지">공지</option>
									<option value="후기">후기</option>
								</select>
							</div>
							
							<!-- 내용 -->
							<div class="form-group">
								<label>내용</label>
								<textarea name="boardContents" class="form-control"></textarea>
							</div>
							
							<!-- 파일업로드 -->
							<div class="form-group">
								<label>파일 업로드</label> <input type="file" name="attaches"
									multiple class="form-control">
							</div>

							<button class="btn btn-primary">등록</button>

						</form>


					</div>

				</div>
				<!-- End Page container-fluid -->

			</div>
			<!-- End page Content -->

		</div>
		<!-- End Content wrapper -->
	</div>
	<!-- End Wrapper -->



	<script
		src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
	<script>
		$('#contents').summernote({
			placeholder : 'Hello Bootstrap 4',
			tabsize : 2,
			height : 100
		});
	</script>

</body>
</html>