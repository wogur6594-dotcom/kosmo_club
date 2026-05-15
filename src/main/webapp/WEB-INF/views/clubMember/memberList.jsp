<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

</head>
<body>

	<div class="container mt-5">

		<h2 class="mb-4">동호회 회원 목록</h2>

		<table class="table table-bordered">

			<thead>
				<tr>
					<th>이름</th>
					<th>아이디</th>
					<th>권한</th>
					<th>관리</th>
				</tr>
			</thead>

			<tbody>

				<c:forEach items="${list}" var="dto">

					<tr>

						<td>${dto.memberName}</td>

						<td>${dto.memberId}</td>

						<td><c:choose>

								<c:when test="${dto.roleNum eq 1}">
								회장
							</c:when>

								<c:otherwise>
								회원
							</c:otherwise>

							</c:choose></td>

						<td><c:if test="${dto.roleNum eq 2}">

								<form action="/clubMember/delegateOwner" method="post"
									style="display: inline;"
									onsubmit="return confirm('회장을 위임하시겠습니까?');">

									<input type="hidden" name="clubNum" value="${clubNum}">

									<input type="hidden" name="memberNum" value="${dto.memberNum}">

									<button type="submit" class="btn btn-sm btn-warning">
										회장 위임</button>

								</form>

								<form action="/clubMember/kick" method="post"
									style="display: inline;"
									onsubmit="return confirm('이새끼 짜를래?');">

									<input type="hidden" name="clubNum" value="${clubNum}">

									<input type="hidden" name="memberNum" value="${dto.memberNum}">

									<button type="submit" class="btn btn-sm btn-danger">
										강퇴</button>

								</form>

							</c:if></td>

					</tr>

				</c:forEach>

			</tbody>

		</table>

	</div>

</body>
</html>