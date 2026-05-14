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

.mb-lg {
	margin-bottom: 40px;
}

.bg-secondary-container {
	background-color: #fff1e6;
}

.bg-secondary {
	background-color: #a35400;
}

.text-on-secondary, .text-on-primary {
	color: white;
}

.text-on-secondary-container, .text-on-surface {
	color: #2b1b12;
}

.text-on-surface-variant {
	color: #6f5b4c;
}

.bg-primary {
	background-color: #a35400;
}

.bg-surface {
	background-color: white;
}

.bg-surface-container-low {
	background-color: #f7eee8;
}

.card-img-fix {
	height: 220px;
	object-fit: cover;
}

.h-48 {
	height: 220px;
}

.card-img-fix {
	width: 100%;
	height: 220px;
	object-fit: cover;
	display: block;
}

.rounded-3xl {
	border-radius: 24px;
}

.gap-sm {
	gap: 8px;
}

.mb-sm {
	margin-bottom: 16px;
}

.mb-xs {
	margin-bottom: 8px;
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

.bg-primary {
	background-color: #a35400 !important;
}

.text-primary {
	color: #a35400 !important;
}

.btn-primary {
	background-color: #a35400 !important;
	border-color: #a35400 !important;
}

a {
	color: #a35400;
}

.category-active, .active-page {
	background-color: #a35400 !important;
	color: white !important;
}

/* 링크 hover 시 파란색 방지 */
a:hover {
	color: inherit !important;
	text-decoration: none !important;
}

/* 카테고리 버튼 hover 색상 고정 */
.category-filter:hover {
	background-color: #f7eee8 !important;
	color: #6f5b4c !important;
	text-decoration: none !important;
}

/* 선택된 카테고리는 hover 해도 갈색 유지 */
.category-filter.category-active:hover {
	background-color: #a35400 !important;
	color: white !important;
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
		<!-- Hero Section -->
		<section class="max-w-container-max mx-auto px-gutter py-lg">
			<div
				class="relative bg-secondary-container rounded-3xl overflow-hidden min-h-[320px] flex items-center shadow-sm">
				<div class="relative z-10 p-xl max-w-lg">
					<h1
						class="font-headline-lg text-headline-lg text-on-secondary-container mb-sm">우리
						동네 모임</h1>
					<p
						class="font-body-lg text-body-lg text-on-secondary-container opacity-90 mb-md">취향이
						비슷한 이웃들을 만나보세요. 운동부터 공부까지, 즐거운 동네 생활이 시작됩니다.</p>
					<a href="./create"
						class="inline-flex items-center gap-2
	bg-[#a35400] hover:bg-[#8b4700]
	text-white font-semibold
	px-8 py-4
	rounded-2xl
	shadow-[0_8px_20px_rgba(163,84,0,0.25)]
	hover:shadow-[0_12px_28px_rgba(163,84,0,0.35)]
	transition-all duration-300
	active:scale-95">

						<span class="material-symbols-outlined text-[22px]">
							add_circle </span> 모임 만들기
					</a>
				</div>
				<div class="absolute right-0 top-0 bottom-0 w-1/2 hidden md:block">
					<img alt="People meeting in a cafe"
						class="w-full h-full object-cover"
						data-alt="A warm and inviting scene of diverse neighbors gathered around a rustic wooden table in a sunlit community cafe. They are laughing and interacting naturally, sharing coffee and pastries. The lighting is soft and golden, emphasizing a light-mode aesthetic with warm orange and green accents. The style is modern, cinematic, and evokes a strong sense of local connectivity and friendly neighborhood spirit."
						src="https://lh3.googleusercontent.com/aida-public/AB6AXuDIwUmn0tFmQkgSwMFy61P73eTt15HCCGwBZt7kXYKafUinjmG966bTbjMQQI0Z4sPFaxa90-FeETB9o6SMw1iLZPmmsMnsZtU5SjuEXFrB9iF5YIZ9dpgBMVoBtsuQcDNTZQBHKFw_NzxfI6XFF5vq-N7Ao25vXevP8Xa-vWM4DwXkePrPxzOqW2Z_EcAxSUFwQsxR_vFUX2mopRZZmHT3BXwPoHiLZOp8ibnA7eTKPLwoxP7HDHOXjwfbIKcb472D8jQ1QT4ftZEF" />
				</div>
			</div>
		</section>
		<!-- Filters Section -->
		<section class="max-w-container-max mx-auto px-gutter mb-lg">

			<div class="flex flex-wrap gap-sm items-center">

				<span class="font-label-lg text-label-lg text-on-surface mr-sm">
					관심사별로 찾기: </span>

				<!-- 전체 -->
				<a href="${pageContext.request.contextPath}/club/list"
					class="category-filter px-md py-2 rounded-full
			${empty param.clubCategory
			? 'bg-primary text-on-primary category-active'
			: 'bg-surface-container-low text-on-surface-variant'}
			font-label-lg text-label-lg active:scale-95 transition-all">

					전체 </a>

				<!-- 운동 -->
				<a
					href="${pageContext.request.contextPath}/club/list?clubCategory=운동"
					class="category-filter px-md py-2 rounded-full
			${param.clubCategory eq '운동'
			? 'bg-primary text-on-primary category-active'
			: 'bg-surface-container-low text-on-surface-variant'}
			font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">

					<span class="material-symbols-outlined text-[18px]">
						exercise </span> 운동
				</a>

				<!-- 맛집 -->
				<a
					href="${pageContext.request.contextPath}/club/list?clubCategory=맛집"
					class="category-filter px-md py-2 rounded-full
			${param.clubCategory eq '맛집'
			? 'bg-primary text-on-primary category-active'
			: 'bg-surface-container-low text-on-surface-variant'}
			font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">

					<span class="material-symbols-outlined text-[18px]">
						restaurant </span> 맛집
				</a>

				<!-- 여행 -->
				<a
					href="${pageContext.request.contextPath}/club/list?clubCategory=여행"
					class="category-filter px-md py-2 rounded-full
			${param.clubCategory eq '여행'
			? 'bg-primary text-on-primary category-active'
			: 'bg-surface-container-low text-on-surface-variant'}
			font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">

					<span class="material-symbols-outlined text-[18px]">
						travel_explore </span> 여행
				</a>

				<!-- 음악 -->
				<a
					href="${pageContext.request.contextPath}/club/list?clubCategory=음악"
					class="category-filter px-md py-2 rounded-full
			${param.clubCategory eq '음악'
			? 'bg-primary text-on-primary category-active'
			: 'bg-surface-container-low text-on-surface-variant'}
			font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">

					<span class="material-symbols-outlined text-[18px]">
						music_note </span> 음악
				</a>

				<!-- 스터디 -->
				<a
					href="${pageContext.request.contextPath}/club/list?clubCategory=스터디"
					class="category-filter px-md py-2 rounded-full
			${param.clubCategory eq '스터디'
			? 'bg-primary text-on-primary category-active'
			: 'bg-surface-container-low text-on-surface-variant'}
			font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">

					<span class="material-symbols-outlined text-[18px]"> school
				</span> 스터디
				</a>

				<!-- 기타 -->
				<a
					href="${pageContext.request.contextPath}/club/list?clubCategory=기타"
					class="category-filter px-md py-2 rounded-full
			${param.clubCategory eq '기타'
			? 'bg-primary text-on-primary category-active'
			: 'bg-surface-container-low text-on-surface-variant'}
			font-label-lg text-label-lg active:scale-95 transition-all flex items-center gap-1">

					<span class="material-symbols-outlined text-[18px]">
						more_horiz </span> 기타
				</a>

			</div>

		</section>
		<!-- Clubs Grid (Bento Style) -->

		<section class="max-w-container-max mx-auto px-gutter">
			<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-md">

				<c:forEach items="${list}" var="dto">

					<a href="./detail?clubNum=${dto.clubNum}&page=${pager.page}"
						class="group bg-surface rounded-3xl overflow-hidden shadow-[0_20px_40px_rgba(154,70,0,0.05)] hover:shadow-[0_20px_40px_rgba(154,70,0,0.1)] transition-all border border-outline-variant/30"
						style="text-decoration: none; color: inherit;">

						<div class="h-48 overflow-hidden">
							<c:choose>
								<c:when test="${not empty dto.fileDTO}">
									<img src="/files/club/${dto.fileDTO.fileName}"
										alt="${dto.clubName}"
										class="w-full card-img-fix group-hover:scale-105 transition-transform duration-500">
								</c:when>

								<c:otherwise>
									<img src="https://via.placeholder.com/600x400?text=No+Image"
										alt="no image"
										class="w-full card-img-fix group-hover:scale-105 transition-transform duration-500">
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
								지역 : ${dto.clubLocation}</p>

							<div
								class="flex items-center justify-between border-t border-outline-variant/30 pt-sm">
								<span class="flex items-center font-label-lg"
									style="
		color: ${dto.currentMember >= dto.clubMax ? '#d93025' : '#1e8e3e'};
		font-weight: 700;
	">

									<span class="w-2 h-2 rounded-full mr-2"
									style="
			background-color: ${dto.currentMember >= dto.clubMax ? '#d93025' : '#1e8e3e'};
		">
								</span> 정원 : ${dto.currentMember} / ${dto.clubMax}명

								</span> <span
									class="text-primary font-label-lg hover:underline transition-all">
									상세보기 </span>
							</div>
						</div>


					</a>

				</c:forEach>
			</div>


			<div class="paging">

				<c:if test="${pager.pre}">
					<a
						href="${pageContext.request.contextPath}/club/list?page=${pager.start-1}&clubCategory=${pager.clubCategory}">
						Previous </a>
				</c:if>

				<c:forEach begin="${pager.start}" end="${pager.end}" var="i">
					<a
						href="${pageContext.request.contextPath}/club/list?page=${i}&clubCategory=${pager.clubCategory}"
						class="${pager.page eq i ? 'active-page' : ''}"> ${i} </a>
				</c:forEach>

				<c:if test="${pager.next}">
					<a
						href="${pageContext.request.contextPath}/club/list?page=${pager.end+1}&clubCategory=${pager.clubCategory}">
						Next </a>
				</c:if>

			</div>


		</section>



	</main>
	<!-- Footer -->
	<footer
		class="w-full py-xl bg-surface-container-low dark:bg-surface-dim border-t border-outline-variant dark:border-outline">
		<div
			class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-md px-gutter max-w-container-max mx-auto">
			<div class="flex flex-col gap-sm">
				<div
					class="text-headline-sm font-headline-sm font-bold text-on-surface-variant flex items-center gap-2">
					<span class="material-symbols-outlined">eco</span> Kosmo
				</div>
				<p
					class="font-body-sm text-body-sm text-on-surface-variant opacity-80">©
					2026 Kosmo 팀프로젝트</p>
			</div>
			<div class="flex flex-col gap-xs">
				<h4 class="font-label-lg text-label-lg text-on-surface mb-xs">Community</h4>
				<a
					class="font-body-sm text-body-sm text-on-surface-variant dark:text-surface-variant hover:underline hover:text-primary transition-colors"
					href="#">About Us</a> <a
					class="font-body-sm text-body-sm text-on-surface-variant dark:text-surface-variant hover:underline hover:text-primary transition-colors"
					href="#">Regional Info</a> <a
					class="font-body-sm text-body-sm text-on-surface-variant dark:text-surface-variant hover:underline hover:text-primary transition-colors"
					href="#">Business Inquiry</a>
			</div>
			<div class="flex flex-col gap-xs">
				<h4 class="font-label-lg text-label-lg text-on-surface mb-xs">Support</h4>
				<a
					class="font-body-sm text-body-sm text-on-surface-variant dark:text-surface-variant hover:underline hover:text-primary transition-colors"
					href="#">Help Center</a> <a
					class="font-body-sm text-body-sm text-on-surface-variant dark:text-surface-variant hover:underline hover:text-primary transition-colors"
					href="#">Terms of Service</a> <a
					class="font-body-sm text-body-sm text-on-surface-variant dark:text-surface-variant hover:underline hover:text-primary transition-colors"
					href="#">Privacy Policy</a>
			</div>
			<div class="flex flex-col gap-sm">
				<h4 class="font-label-lg text-label-lg text-on-surface mb-xs">Download
					App</h4>
				<div class="flex gap-sm">
					<div
						class="w-10 h-10 bg-surface-container-highest rounded-lg flex items-center justify-center cursor-pointer hover:bg-primary/10 transition-colors">
						<span class="material-symbols-outlined text-on-surface-variant">phone_iphone</span>
					</div>
					<div
						class="w-10 h-10 bg-surface-container-highest rounded-lg flex items-center justify-center cursor-pointer hover:bg-primary/10 transition-colors">
						<span class="material-symbols-outlined text-on-surface-variant">ad_units</span>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- Mobile BottomNavBar -->
	<div
		class="md:hidden fixed bottom-0 left-0 right-0 bg-surface/95 backdrop-blur-md border-t border-outline-variant z-50 flex justify-around items-center h-16 px-gutter">
		<button
			class="flex flex-col items-center gap-1 text-on-surface-variant">
			<span class="material-symbols-outlined">home</span> <span
				class="text-[10px] font-label-sm">Home</span>
		</button>
		<button
			class="flex flex-col items-center gap-1 text-on-surface-variant">
			<span class="material-symbols-outlined">explore</span> <span
				class="text-[10px] font-label-sm">Used Goods</span>
		</button>
		<button class="flex flex-col items-center gap-1 text-primary">
			<span class="material-symbols-outlined"
				style="font-variation-settings: 'FILL' 1;">groups</span> <span
				class="text-[10px] font-label-sm font-bold">Clubs</span>
		</button>
		<button
			class="flex flex-col items-center gap-1 text-on-surface-variant">
			<span class="material-symbols-outlined">chat</span> <span
				class="text-[10px] font-label-sm">Chat</span>
		</button>
		<button
			class="flex flex-col items-center gap-1 text-on-surface-variant">
			<span class="material-symbols-outlined">person</span> <span
				class="text-[10px] font-label-sm">Profile</span>
		</button>
	</div>
</body>
</html>