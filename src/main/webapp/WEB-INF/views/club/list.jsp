<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>동호회 목록</title>
<script src="https://cdn.tailwindcss.com"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
	rel="stylesheet">

<style>
main {
	max-width: 1200px;
	margin: 0 auto;
	padding: 40px 20px;
}

.navbar-collapse {
	visibility: visible !important;
}

.navbar-nav {
	display: flex !important;
}

.navbar .container {
	max-width: 1200px;
}

.max-w-container-max {
	max-width: 1200px;
}

.px-gutter {
	padding-left: 20px;
	padding-right: 20px;
}

.py-lg {
	padding-top: 40px;
	padding-bottom: 40px;
}

.p-xl {
	padding: 48px;
}

.p-md {
	padding: 24px;
}

.gap-md {
	gap: 24px;
}

.mb-md {
	margin-bottom: 24px;
}

.mb-sm {
	margin-bottom: 16px;
}

.mb-xs {
	margin-bottom: 8px;
}

.bg-secondary-container {
	background-color: #fff1e6;
}

.text-on-primary {
	color: white;
}

.text-on-secondary-container, .text-on-surface {
	color: #2b1b12;
}

.text-on-surface-variant {
	color: #6f5b4c;
}

.bg-primary {
	background-color: #a35400 !important;
}

.bg-surface {
	background-color: white;
}

.bg-surface-container-low {
	background-color: #f7eee8;
}

.text-primary {
	color: #a35400 !important;
}

.card-img-fix {
	width: 100%;
	height: 220px;
	object-fit: cover;
	display: block;
}

.h-48 {
	height: 220px;
}

.rounded-3xl {
	border-radius: 24px;
}

.gap-sm {
	gap: 8px;
}

.pt-sm {
	padding-top: 16px;
}

.px-sm {
	padding-left: 12px;
	padding-right: 12px;
}

.px-md {
	padding-left: 24px;
	padding-right: 24px;
}

.font-headline-lg {
	font-size: 28px;
	font-weight: 700;
}

.font-headline-sm {
	font-size: 22px;
	font-weight: 700;
}

.paging {
	margin-top: 40px;
	text-align: center;
}

.paging a {
	display: inline-block;
	padding: 8px 14px;
	margin: 0 4px;
	border-radius: 8px;
	background-color: #f7eee8;
	color: #a35400;
	text-decoration: none;
}

.paging .active-page {
	background-color: #a35400;
	color: white;
}

a {
	color: #a35400;
}

.category-active, .active-page {
	background-color: #a35400 !important;
	color: white !important;
}

a:hover {
	color: inherit !important;
	text-decoration: none !important;
}

.category-filter:hover {
	background-color: #f7eee8 !important;
	color: #6f5b4c !important;
	text-decoration: none !important;
}

.category-filter.category-active:hover {
	background-color: #a35400 !important;
	color: white !important;
}

.club-capacity {
	display: inline-flex;
	align-items: center;
	gap: 7px;
	font-weight: 700;
}

.club-capacity.available {
	color: #16a34a;
}

.club-capacity.full {
	color: #dc2626;
}

.club-capacity-dot {
	width: 10px;
	height: 10px;
	border-radius: 50%;
	background-color: currentColor;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.12);
	flex-shrink: 0;
}
</style>
</head>

<body id="page-top" class="text-on-background min-h-screen"
	style="background-color: #f8f5f1;">

	<c:if test="${not empty msg}">
		<script>
			alert("${msg}");
		</script>
	</c:if>

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<main class="pb-5">

		<section class="max-w-container-max mx-auto px-gutter py-lg">
			<div
				class="relative bg-secondary-container rounded-3xl overflow-hidden min-h-[320px] flex items-center shadow-sm">
				<div class="relative z-10 p-xl max-w-lg">
					<h1
						class="font-headline-lg text-headline-lg text-on-secondary-container mb-sm">
						우리 동네 모임</h1>

					<p
						class="font-body-lg text-body-lg text-on-secondary-container opacity-90 mb-md">
						취향이 비슷한 이웃들을 만나보세요. 운동부터 공부까지, 즐거운 동네 생활이 시작됩니다.</p>

					<a href="./create"
						class="inline-flex items-center gap-2 bg-[#a35400] hover:bg-[#8b4700] text-white font-semibold px-8 py-4 rounded-2xl shadow-[0_8px_20px_rgba(163,84,0,0.25)] hover:shadow-[0_12px_28px_rgba(163,84,0,0.35)] transition-all duration-300 active:scale-95">
						<span class="material-symbols-outlined text-[22px]">add_circle</span>
						모임 만들기
					</a>
				</div>

				<div class="absolute right-0 top-0 bottom-0 w-1/2 hidden md:block">
					<img alt="동호회 대표 이미지" class="w-full h-full object-cover"
						src="https://lh3.googleusercontent.com/aida-public/AB6AXuDIwUmn0tFmQkgSwMFy61P73eTt15HCCGwBZt7kXYKafUinjmG966bTbjMQQI0Z4sPFaxa90-FeETB9o6SMw1iLZPmmsMnsZtU5SjuEXFrB9iF5YIZ9dpgBMVoBtsuQcDNTZQBHKFw_NzxfI6XFF5vq-N7Ao25vXevP8Xa-vWM4DwXkePrPxzOqW2Z_EcAxSUFwQsxR_vFUX2mopRZZmHT3BXwPoHiLZOp8ibnA7eTKPLwoxP7HDHOXjwfbIKcb472D8jQ1QT4ftZEF">
				</div>
			</div>
		</section>

		<div id="club-list"></div>

		<section class="max-w-container-max mx-auto px-gutter mb-2">
			<div class="flex flex-wrap gap-sm items-center">

				<span class="font-label-lg text-label-lg text-on-surface mr-sm">
					관심사별로 찾기: </span> <a
					href="${pageContext.request.contextPath}/club/list#club-list"
					class="category-filter px-md py-2 rounded-full
					${empty param.clubCategory ? 'bg-primary text-on-primary category-active' : 'bg-surface-container-low text-on-surface-variant'}
					font-label-lg text-label-lg active:scale-95 transition-all">
					전체 </a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=운동#club-list"
					class="category-filter px-md py-2 rounded-full
					${param.clubCategory eq '운동' ? 'bg-primary text-on-primary category-active' : 'bg-surface-container-low text-on-surface-variant'}
					font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">exercise</span>
					운동
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=맛집#club-list"
					class="category-filter px-md py-2 rounded-full
					${param.clubCategory eq '맛집' ? 'bg-primary text-on-primary category-active' : 'bg-surface-container-low text-on-surface-variant'}
					font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">restaurant</span>
					맛집
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=여행#club-list"
					class="category-filter px-md py-2 rounded-full
					${param.clubCategory eq '여행' ? 'bg-primary text-on-primary category-active' : 'bg-surface-container-low text-on-surface-variant'}
					font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">travel_explore</span>
					여행
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=음악#club-list"
					class="category-filter px-md py-2 rounded-full
					${param.clubCategory eq '음악' ? 'bg-primary text-on-primary category-active' : 'bg-surface-container-low text-on-surface-variant'}
					font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">music_note</span>
					음악
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=스터디#club-list"
					class="category-filter px-md py-2 rounded-full
					${param.clubCategory eq '스터디' ? 'bg-primary text-on-primary category-active' : 'bg-surface-container-low text-on-surface-variant'}
					font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">school</span>
					스터디
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=기타#club-list"
					class="category-filter px-md py-2 rounded-full
					${param.clubCategory eq '기타' ? 'bg-primary text-on-primary category-active' : 'bg-surface-container-low text-on-surface-variant'}
					font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">more_horiz</span>
					기타
				</a>

			</div>
		</section>

		<section class="max-w-container-max mx-auto px-gutter mb-4">
			<form action="${pageContext.request.contextPath}/club/list#club-list"
				method="get"
				class="bg-white rounded-3xl p-4 shadow-sm flex flex-wrap items-center gap-3">

				<input type="hidden" name="clubCategory"
					value="${param.clubCategory}"> <select name="kind"
					class="px-4 py-3 rounded-2xl bg-surface-container-low text-on-surface-variant font-semibold border-0 outline-none">

					<option value="">전체</option>

					<option value="name" ${param.kind eq 'name' ? 'selected' : ''}>
						모임명</option>

					<option value="location"
						${param.kind eq 'location' ? 'selected' : ''}>지역</option>

				</select> <input type="text" name="search" value="${param.search}"
					placeholder="모임명이나 지역을 검색해보세요"
					class="flex-1 min-w-[240px] px-4 py-3 rounded-2xl bg-surface-container-low text-on-surface border-0 outline-none">

				<button type="submit"
					class="px-6 py-3 rounded-2xl bg-primary text-white font-bold shadow-sm hover:opacity-90 transition-all">
					검색</button>

				<a href="${pageContext.request.contextPath}/club/list#club-list"
					class="px-5 py-3 rounded-2xl bg-surface-container-low text-primary font-bold">
					초기화 </a>

			</form>
		</section>

		<section class="max-w-container-max mx-auto px-gutter">
			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-md">

				<c:forEach items="${list}" var="dto">

					<a
						href="./detail?clubNum=${dto.clubNum}&page=${pager.page}&clubCategory=${param.clubCategory}&kind=${param.kind}&search=${param.search}"
						class="club-card-link group bg-surface rounded-3xl overflow-hidden shadow-[0_20px_40px_rgba(154,70,0,0.05)] hover:shadow-[0_20px_40px_rgba(154,70,0,0.1)] transition-all border border-outline-variant/30">

						<div class="h-48 overflow-hidden">
							<c:choose>
								<c:when
									test="${not empty dto.fileDTO and not empty dto.fileDTO.fileName}">
									<img
										src="${pageContext.request.contextPath}/files/club/${dto.fileDTO.fileName}"
										alt="${dto.clubName}"
										class="w-full card-img-fix group-hover:scale-105 transition-transform duration-500">
								</c:when>

								<c:otherwise>
									<c:choose>
										<c:when test="${dto.clubCategory eq '운동'}">
											<img
												src="${pageContext.request.contextPath}/image/default-sports.jpg"
												alt="운동 기본 이미지"
												class="w-full card-img-fix default-club-image group-hover:scale-105 transition-transform duration-500">
										</c:when>

										<c:when test="${dto.clubCategory eq '맛집'}">
											<img
												src="${pageContext.request.contextPath}/image/default-food.jpg"
												alt="맛집 기본 이미지"
												class="w-full card-img-fix default-club-image group-hover:scale-105 transition-transform duration-500">
										</c:when>

										<c:when test="${dto.clubCategory eq '여행'}">
											<img
												src="${pageContext.request.contextPath}/image/default-travel.jpg"
												alt="여행 기본 이미지"
												class="w-full card-img-fix default-club-image group-hover:scale-105 transition-transform duration-500">
										</c:when>

										<c:when test="${dto.clubCategory eq '음악'}">
											<img
												src="${pageContext.request.contextPath}/image/default-music.jpg"
												alt="음악 기본 이미지"
												class="w-full card-img-fix default-club-image group-hover:scale-105 transition-transform duration-500">
										</c:when>

										<c:when test="${dto.clubCategory eq '스터디'}">
											<img
												src="${pageContext.request.contextPath}/image/default-study.jpg"
												alt="스터디 기본 이미지"
												class="w-full card-img-fix default-club-image group-hover:scale-105 transition-transform duration-500">
										</c:when>

										<c:otherwise>
											<img
												src="${pageContext.request.contextPath}/image/default-club.jpg"
												alt="기본 이미지"
												class="w-full card-img-fix default-club-image group-hover:scale-105 transition-transform duration-500">
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="p-md">
							<div class="flex justify-between items-start mb-xs">
								<span
									class="px-sm py-0.5 bg-secondary-container text-on-secondary-container text-label-sm font-label-sm rounded-full">
									${dto.clubCategory} </span> <span
									class="flex items-center text-on-surface-variant text-label-sm">
									<span class="material-symbols-outlined text-[16px] mr-1">group</span>
									${dto.currentMember}명
								</span>
							</div>

							<h3
								class="font-headline-sm text-headline-sm text-on-surface mb-xs">
								${dto.clubName}</h3>

							<p
								class="font-body-sm text-body-sm text-on-surface-variant line-clamp-2 mb-md">
								회장 : ${dto.ownerName}</p>

							<p
								class="font-body-sm text-body-sm text-on-surface-variant line-clamp-2 mb-md">
								지역 : ${dto.clubLocation}</p>

							<div
								class="flex items-center justify-between border-t border-outline-variant/30 pt-sm">

								<span
									class="club-capacity ${dto.currentMember >= dto.clubMax ? 'full' : 'available'}">
									<span class="club-capacity-dot"></span> 정원 :
									${dto.currentMember} / ${dto.clubMax}명
								</span> <span
									class="text-primary font-label-lg hover:underline transition-all">
									상세보기 </span>

							</div>
						</div>
					</a>

				</c:forEach>

			</div>

			<div id="paging-position"></div>

			<div class="paging">

				<c:if test="${pager.pre}">
					<a
						href="${pageContext.request.contextPath}/club/list?page=${pager.start-1}&clubCategory=${param.clubCategory}&kind=${param.kind}&search=${param.search}#paging-position">
						Previous </a>
				</c:if>

				<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
					<a
						href="${pageContext.request.contextPath}/club/list?page=${i}&clubCategory=${param.clubCategory}&kind=${param.kind}&search=${param.search}#paging-position"
						class="${pager.page eq i ? 'active-page' : ''}"> ${i} </a>
				</c:forEach>

				<c:if test="${pager.next}">
					<a
						href="${pageContext.request.contextPath}/club/list?page=${pager.end+1}&clubCategory=${param.clubCategory}&kind=${param.kind}&search=${param.search}#paging-position">
						Next </a>
				</c:if>

			</div>

		</section>

	</main>

	<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>

</body>
</html>