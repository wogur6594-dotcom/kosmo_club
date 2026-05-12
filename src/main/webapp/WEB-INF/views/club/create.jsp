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
					<h1 class="h3 mb-4 text-gray-800">모임 만들기</h1>

					<div>
						<form method="post" enctype="multipart/form-data">

							<div class="form-group">
								<label>동호회 이름</label> <input type="text" name="clubName"
									class="form-control">
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
									class="form-control">
							</div>

							<div class="form-group">
								<label>정원</label> <input type="number" name="clubMax"
									class="form-control" min="1">
							</div>


							<div class="form-group">
								<label>사진 업로드</label> <input type="file" name="attaches"
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