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

<link rel="stylesheet" href="/css/common.css">

</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="club-wait-wrap">

		<div class="club-wait-card">

			<div class="club-wait-header">

				<div>
					<h2 class="club-wait-title">가입 신청 목록</h2>

					<p class="club-wait-desc">동호회 가입 신청 회원을 승인할 수 있습니다.</p>
				</div>

				<a href="/club/detail?clubNum=${clubNum}" class="btn-light-brown">
					동호회로 돌아가기 </a>

			</div>

			<c:if test="${empty list}">

				<div class="empty-wait-box">가입 신청자가 없습니다.</div>

			</c:if>

			<c:if test="${not empty list}">

				<table class="table club-wait-table">

					<thead>

						<tr>
							<th>이름</th>
							<th>아이디</th>
							<th>전화번호</th>
							<th>승인</th>
						</tr>

					</thead>

					<tbody>

						<c:forEach items="${list}" var="dto">

							<tr>

								<td class="wait-member-name">${dto.memberName}</td>

								<td>${dto.memberId}</td>

								<td>${dto.memberPhone}</td>

								<td>

									<form action="/clubMember/approve" method="post">

										<input type="hidden" name="clubNum" value="${clubNum}">

										<input type="hidden" name="memberNum" value="${dto.memberNum}">

										<button type="submit" class="btn-wait-approve"
											onclick="return confirm('가입을 승인하시겠습니까?');">승인</button>

									</form>

								</td>

							</tr>

						</c:forEach>

					</tbody>

				</table>

			</c:if>

		</div>

	</div>

</body>
</html>