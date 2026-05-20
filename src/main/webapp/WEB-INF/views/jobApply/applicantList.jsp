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

<style>
body {
	background-color: #fff7f3;
}

.list-box {
	max-width: 900px;
	margin: 50px auto;
	background: white;
	padding: 35px;
	border-radius: 18px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.title {
	font-size: 28px;
	font-weight: 800;
	margin-bottom: 30px;
	color: #3f2d20;
}

.table th {
	background-color: #fff3e8;
}

.badge-wait {
	background: #ffe8cc;
	color: #d9480f;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
}

.badge-accept {
	background: #d3f9d8;
	color: #2b8a3e;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
}

.badge-reject {
	background: #ffe3e3;
	color: #c92a2a;
	padding: 6px 10px;
	border-radius: 8px;
	font-size: 12px;
	font-weight: 700;
}
</style>

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