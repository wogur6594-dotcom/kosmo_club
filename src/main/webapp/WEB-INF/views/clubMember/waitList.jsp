<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 신청 목록</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.wait-box {
	max-width: 850px;
	margin: 50px auto;
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

.btn-brown {
	background-color: #a35400;
	color: white;
	border-radius: 10px;
	font-weight: 700;
}

.btn-brown:hover {
	background-color: #8a4600;
	color: white;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="container">

		<div class="wait-box">

			<h2 class="page-title">가입 신청 목록</h2>

			<c:if test="${empty list}">
				<div class="text-center text-muted p-5">가입 신청자가 없습니다.</div>
			</c:if>

			<c:if test="${not empty list}">

				<table class="table table-hover">

					<thead>
						<tr>
							<th>회원번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>승인</th>
						</tr>
					</thead>

					<tbody>

						<c:forEach items="${list}" var="dto">

							<tr>
								<td>${dto.memberNum}</td>
								<td>${dto.memberId}</td>
								<td>${dto.memberName}</td>
								<td>
									<form action="/clubMember/approve" method="post">
										<input type="hidden" name="clubNum" value="${clubNum}">
										<input type="hidden" name="memberNum" value="${dto.memberNum}">

										<button type="submit" class="btn btn-sm btn-brown"
											onclick="return confirm('가입을 승인하시겠습니까?');">승인</button>
									</form>
								</td>
							</tr>

						</c:forEach>

					</tbody>

				</table>

			</c:if>

			<a href="/club/detail?clubNum=${clubNum}"
				class="btn btn-secondary mt-3"> 동호회로 돌아가기 </a>

		</div>

	</div>

</body>
</html>