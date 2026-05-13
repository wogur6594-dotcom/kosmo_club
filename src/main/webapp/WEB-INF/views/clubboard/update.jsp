<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #f8f5f1;
}

.update-box {
	background: white;
	padding: 40px;
	border-radius: 20px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.preview-img {
	width: 200px;
	height: 200px;
	object-fit: cover;
	border-radius: 14px;
	margin-right: 10px;
	margin-bottom: 10px;
	border: 1px solid #ddd;
}

.title-color {
	color: #8b5e3c;
	font-weight: bold;
}

.btn-brown {
	background-color: #8b5e3c;
	color: white;
	border: none;
}

.btn-brown:hover {
	background-color: #6f472b;
	color: white;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container mt-5 mb-5">

		<div class="update-box">

			<h2 class="mb-4 title-color">게시글 수정</h2>

			<form action="./update" method="post" enctype="multipart/form-data">

				<input type="hidden" name="boardNum" value="${dto.boardNum}">
				<input type="hidden" name="clubNum" value="${dto.clubNum}">

				<div class="form-group">
					<label><strong>제목</strong></label>
					<input type="text" name="boardTitle" value="${dto.boardTitle}"
						class="form-control">
				</div>

				<div class="form-group">
					<label><strong>카테고리</strong></label>

					<select name="boardCategory" class="form-control">
						<option value="자유" ${dto.boardCategory eq '자유' ? 'selected' : ''}>자유</option>
						<option value="일정" ${dto.boardCategory eq '일정' ? 'selected' : ''}>일정</option>
						<option value="공지" ${dto.boardCategory eq '공지' ? 'selected' : ''}>공지</option>
						<option value="후기" ${dto.boardCategory eq '후기' ? 'selected' : ''}>후기</option>
					</select>
				</div>

				<div class="form-group">
					<label><strong>내용</strong></label>
					<textarea name="boardContents" class="form-control" rows="10">${dto.boardContents}</textarea>
				</div>

				<div class="form-group">
					<label><strong>현재 이미지</strong></label>

					<div>
						<c:choose>
							<c:when test="${not empty dto.list}">

								<c:forEach items="${dto.list}" var="f">

									<div style="display: inline-block; margin-right: 15px; vertical-align: top;">

										<img src="${pageContext.request.contextPath}/files/clubboard/${f.fileName}"
											class="preview-img"
											alt="${f.oriName}">

										<div class="text-center mt-2">

											<c:if test="${f.isMain}">
												<div class="badge badge-warning">
													대표 이미지
												</div>
											</c:if>

											<c:if test="${not f.isMain}">
												<button type="submit"
													form="mainImageForm${f.fileNum}"
													class="btn btn-sm btn-outline-warning mt-1">
													대표 설정
												</button>
											</c:if>

										</div>

									</div>

								</c:forEach>

							</c:when>

							<c:otherwise>
								<p class="text-muted">등록된 이미지가 없습니다.</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="form-group">
					<label><strong>이미지 추가</strong></label>
					<input type="file" name="attaches" class="form-control-file" multiple>
				</div>

				<div class="mt-4 d-flex justify-content-between">

					<a href="./detail?boardNum=${dto.boardNum}&clubNum=${dto.clubNum}"
						class="btn btn-secondary">
						취소
					</a>

					<button type="submit" class="btn btn-brown">
						수정완료
					</button>

				</div>

			</form>

			<c:if test="${not empty dto.list}">
				<c:forEach items="${dto.list}" var="f">

					<form id="mainImageForm${f.fileNum}" action="./mainImage" method="post">
						<input type="hidden" name="fileNum" value="${f.fileNum}">
						<input type="hidden" name="boardNum" value="${dto.boardNum}">
						<input type="hidden" name="clubNum" value="${dto.clubNum}">
					</form>

				</c:forEach>
			</c:if>

		</div>

	</div>

</body>
</html>