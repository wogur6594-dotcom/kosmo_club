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

<link rel="stylesheet" href="/css/common.css">
</head>

<body>

	<div class="club-member-wrap">

		<div class="club-member-card">

			<div class="club-member-header">
				<div>
					<h2 class="club-member-title">동호회 회원 목록</h2>
					<p class="club-member-desc">동호회 회장과 가입 회원을 관리할 수 있습니다.</p>
				</div>

				<a href="/club/detail?clubNum=${clubNum}" class="btn-light-brown">
					동호회로 돌아가기 </a>
			</div>

			<table class="table club-member-table">

				<thead>
					<tr>
						<th>이름</th>
						<th>아이디</th>
						<th>전화번호</th>
						<th>권한</th>
						<th>관리</th>
					</tr>
				</thead>

				<tbody>

					<c:forEach items="${list}" var="dto">

						<tr>
							<td class="member-name">${dto.memberName}</td>

							<td>${dto.memberId}</td>

							<td>${dto.memberPhone}</td>

							<td><c:choose>
									<c:when test="${dto.roleNum eq 1}">
										<span class="member-role-boss">회장</span>
									</c:when>
									<c:otherwise>
										<span class="member-role-normal">회원</span>
									</c:otherwise>
								</c:choose></td>

							<td><c:if test="${dto.roleNum eq 2}">

									<div class="member-action-area">

										<form action="/clubMember/delegateOwner" method="post"
											onsubmit="return confirm('회장을 위임하시겠습니까?');">

											<input type="hidden" name="clubNum" value="${clubNum}">
											<input type="hidden" name="memberNum"
												value="${dto.memberNum}">

											<button type="submit" class="btn-member-delegate">
												회장 위임</button>

										</form>

										<form action="/clubMember/kick" method="post"
											onsubmit="return confirm('정말 해당 회원을 강퇴하시겠습니까?');">

											<input type="hidden" name="clubNum" value="${clubNum}">
											<input type="hidden" name="memberNum"
												value="${dto.memberNum}">

											<button type="submit" class="btn-member-kick">강퇴</button>

										</form>

									</div>

								</c:if></td>
						</tr>

					</c:forEach>

				</tbody>

			</table>

		</div>

	</div>

</body>
</html>