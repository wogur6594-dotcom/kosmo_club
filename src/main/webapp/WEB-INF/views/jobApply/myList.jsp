<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 지원내역</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>
body {
	background-color: #fff7f3;
}

.my-box {
	max-width: 950px;
	margin: 50px auto;
	background: white;
	border-radius: 18px;
	padding: 35px;
	box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
}

.page-title {
	font-size: 28px;
	font-weight: 800;
	color: #3f2d20;
	margin-bottom: 30px;
}

.apply-card {
	border: 1px solid #f1e0d2;
	border-radius: 14px;
	padding: 22px;
	margin-bottom: 18px;
	background-color: #fffaf7;
}

.job-title {
	font-size: 20px;
	font-weight: 800;
	color: #3f2d20;
	text-decoration: none;
}

.job-title:hover {
	color: #ff6f0f;
	text-decoration: none;
}

.meta {
	color: #868e96;
	margin-top: 8px;
	font-size: 14px;
}

.pay {
	font-weight: 800;
	color: #212529;
	margin-top: 10px;
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

.empty-box {
	text-align: center;
	color: #868e96;
	padding: 60px 0;
}

.btn-back {
	background-color: #f1ebe6;
	color: #5f4b3b;
	border-radius: 12px;
	font-weight: 800;
	padding: 8px 18px;
	border: none;
	transition: 0.2s;
}

.btn-back:hover {
	background-color: #e3d8ce;
	color: #3f2d20;
	text-decoration: none;
}
.my-head {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.my-head .page-title {
	margin-bottom: 0;
}

.btn-bookmark {
	background-color: #fff3e6;
	color: #a35400;
	border: 1px solid #ead1bb;
	border-radius: 999px;
	font-weight: 800;
	padding: 9px 18px;
	text-decoration: none;
	transition: 0.2s;
}

.btn-bookmark:hover {
	background-color: #ffe5cc;
	color: #8b4700;
	text-decoration: none;
}
</style>
</head>

<body>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="my-box">

		<div class="my-head">

			<h1 class="page-title">내 지원내역</h1>

			<a href="${pageContext.request.contextPath}/jobBookmark/myList"
				class="btn-bookmark"> 관심 공고 </a>

		</div>

		<c:choose>
			<c:when test="${empty list}">
				<div class="empty-box">아직 지원한 공고가 없습니다.</div>
			</c:when>

			<c:otherwise>
				<c:forEach items="${list}" var="dto">

					<div class="apply-card">

						<div class="d-flex justify-content-between align-items-center">

							<a
								href="${pageContext.request.contextPath}/job/detail?jobNum=${dto.jobNum}"
								class="job-title"> ${dto.jobTitle} </a>

							<c:choose>
								<c:when test="${dto.applyStatus eq 'WAIT'}">
									<span class="badge-wait">대기중</span>
								</c:when>

								<c:when test="${dto.applyStatus eq 'ACCEPT'}">
									<span class="badge-accept">승인</span>
								</c:when>

								<c:otherwise>
									<span class="badge-reject">거절</span>
								</c:otherwise>
							</c:choose>
							<!-- 대기중 취소 -->
							<c:if test="${dto.applyStatus eq 'WAIT'}">
								<form
									action="${pageContext.request.contextPath}/jobApply/cancel"
									method="post" style="display: inline;"
									onsubmit="return confirm('지원 취소하시겠습니까?');">

									<input type="hidden" name="jobNum" value="${dto.jobNum}">

									<button type="submit" class="btn btn-sm btn-secondary mt-2">
										지원 취소</button>
								</form>
							</c:if>
							<!-- 대기중 취소 끝 -->
						</div>

						<div class="meta">${dto.jobLocation}·${dto.jobWorkDay}·
							${dto.jobWorkTime}</div>

						<div class="pay">${dto.jobPay}</div>

						<div class="meta">지원일 ${dto.applyDateFormat}</div>

					</div>

				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div class="text-right mt-4">

			<a href="javascript:history.back();" class="btn btn-back"> 뒤로가기 </a>

		</div>

	</div>

</body>
</html>