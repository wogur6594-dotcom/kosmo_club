<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<table class="table">
		<thead class="thead-dark">
			<tr>
				<th>No</th>
				<th>Name</th>
				<th>Category</th>
				<th>Location</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="d">
				<tr>
					<td>${d.clubNum}</td>
					<td>${d.clubName}</td>
					<td>${d.clubCategory}</td>
					<td>${d.clubLocation}</td>


				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
		<c:if test="${pager.pre}">
			<a href="./list?page=${pager.start - 1}">이전</a>
		</c:if>

		<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
			<a href="./list?page=${i}">${i}</a>
		</c:forEach>

		<c:if test="${pager.next}">
			<a href="./list?page=${pager.end + 1}">다음</a>
		</c:if>
	</div>

</body>
</html>