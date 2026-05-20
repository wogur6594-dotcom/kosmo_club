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

<link rel="stylesheet" href="/css/common.css">
</head>

<body id="page-top">

	<div id="wrapper">

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<div class="board-create-wrap">

					<div class="board-create-card">

						<div class="board-create-header">

							<span class="board-create-badge">Club Board</span>

							<h1 class="board-create-title">동호회 게시물 등록</h1>

							<p class="board-create-desc">동호회 회원들과 공유할 게시글을 작성해주세요.</p>

						</div>

						<form action="/clubboard/create" method="post"
							enctype="multipart/form-data">

							<input type="hidden" name="clubNum" value="${param.clubNum}">

							<div class="board-form-group">
								<label>제목</label> <input type="text" name="boardTitle"
									class="board-input form-control" placeholder="제목을 입력하세요">
							</div>

							<div class="board-form-group">
								<label for="boardCategory">카테고리</label> <select
									name="boardCategory" id="boardCategory"
									class="board-input form-control">

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

							<div class="board-form-group">
								<label>내용</label>

								<textarea name="boardContents" id="summernote"></textarea>
							</div>

							<div class="board-form-group">
								<label>파일 업로드</label> <input type="file" name="attaches"
									multiple class="board-input form-control">

								<div class="board-file-help">여러 개의 파일을 선택할 수 있습니다.</div>
							</div>

							<div class="board-btn-area">
								<a
									href="${pageContext.request.contextPath}/club/detail?clubNum=${param.clubNum}"
									class="btn btn-light-brown"> 취소 </a>

								<button type="submit" class="btn btn-brown">등록</button>
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
		$('#summernote')
				.summernote(
						{
							placeholder : '내용을 입력하세요',
							tabsize : 2,
							height : 300,
							toolbar : [
									[
											'style',
											[ 'bold', 'italic', 'underline',
													'clear' ] ],
									[ 'font', [ 'fontsize' ] ],
									[ 'color', [ 'color' ] ],
									[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
									[ 'insert', [ 'picture', 'link' ] ],
									[ 'view', [ 'codeview' ] ] ]
						});
	</script>

</body>
</html>