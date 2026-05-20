<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 목록</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="/css/job.css">
</head>

<body>

	<c:if test="${not empty message}">
		<script>
			alert("${message}");
		</script>
	</c:if>

	<div class="list-box">

		<h1 class="title">지원자 목록</h1>

		<table class="table">

			<thead>
				<tr>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>지원일</th>
					<th>상태</th>
					<th>처리</th>
				</tr>
			</thead>

			<tbody>

				<c:forEach items="${list}" var="dto">

					<tr>

						<td>${dto.memberName}</td>

						<td>${dto.memberEmail}</td>

						<td>${dto.memberPhone}</td>

						<td>${dto.applyDateFormat}</td>

						<td><c:choose>

								<c:when test="${dto.applyStatus eq 'WAIT'}">
									<span class="badge-wait">대기중</span>
								</c:when>

								<c:when test="${dto.applyStatus eq 'ACCEPT'}">
									<span class="badge-accept">승인</span>
								</c:when>

								<c:otherwise>
									<span class="badge-reject">거절</span>
								</c:otherwise>

							</c:choose></td>

						<td>

							<form action="./status" method="post" style="display: inline;">

								<input type="hidden" name="applyNum" value="${dto.applyNum}">

								<input type="hidden" name="jobNum" value="${jobNum}"> <input
									type="hidden" name="applyStatus" value="ACCEPT">

								<button class="btn btn-sm btn-success">승인</button>

							</form>

							<form action="./status" method="post" style="display: inline;">

								<input type="hidden" name="applyNum" value="${dto.applyNum}">

								<input type="hidden" name="jobNum" value="${jobNum}"> <input
									type="hidden" name="applyStatus" value="REJECT">

								<button class="btn btn-sm btn-danger">거절</button>

							</form>

						</td>

					</tr>

				</c:forEach>

			</tbody>

		</table>

	</div>

</body>
</html>