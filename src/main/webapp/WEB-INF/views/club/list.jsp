<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>

<html class="light" lang="ko">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<title>Clubs - Neighborhood Marketplace</title>
<script
	src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
	rel="stylesheet" />
<style>
.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
}

body {
	font-family: 'Plus Jakarta Sans', sans-serif;
}
</style>
<script id="tailwind-config">
	tailwind.config = {
		darkMode : "class",
		theme : {
			extend : {
				"colors" : {
					"on-secondary-fixed-variant" : "#00522c",
					"error-container" : "#ffdad6",
					"on-secondary" : "#ffffff",
					"on-tertiary-container" : "#003f74",
					"inverse-on-surface" : "#ffede5",
					"secondary-fixed" : "#9ff5b9",
					"on-tertiary-fixed-variant" : "#004883",
					"outline-variant" : "#ddc1b3",
					"surface-dim" : "#ead6cd",
					"on-primary-fixed" : "#321200",
					"tertiary-container" : "#6aacff",
					"surface-variant" : "#f3ded5",
					"secondary" : "#0d6d3d",
					"primary" : "#9a4600",
					"primary-fixed" : "#ffdbc9",
					"surface-container-lowest" : "#ffffff",
					"outline" : "#8a7266",
					"surface-container" : "#feeae0",
					"primary-fixed-dim" : "#ffb68d",
					"tertiary-fixed" : "#d4e3ff",
					"surface" : "#fff8f6",
					"background" : "#fff8f6",
					"secondary-container" : "#9cf2b6",
					"surface-bright" : "#fff8f6",
					"on-error" : "#ffffff",
					"on-primary-container" : "#682d00",
					"on-tertiary" : "#ffffff",
					"inverse-primary" : "#ffb68d",
					"tertiary" : "#0060ac",
					"surface-container-highest" : "#f3ded5",
					"primary-container" : "#ff8a3d",
					"surface-container-high" : "#f9e4db",
					"surface-container-low" : "#fff1eb",
					"on-error-container" : "#93000a",
					"on-surface" : "#241914",
					"surface-tint" : "#9a4600",
					"on-primary" : "#ffffff",
					"on-tertiary-fixed" : "#001c39",
					"on-secondary-container" : "#157141",
					"error" : "#ba1a1a",
					"on-surface-variant" : "#564338",
					"on-background" : "#241914",
					"inverse-surface" : "#3a2e28",
					"on-primary-fixed-variant" : "#763300",
					"secondary-fixed-dim" : "#83d89e",
					"on-secondary-fixed" : "#00210e",
					"tertiary-fixed-dim" : "#a4c9ff"
				},
				"borderRadius" : {
					"DEFAULT" : "0.25rem",
					"lg" : "0.5rem",
					"xl" : "0.75rem",
					"full" : "9999px"
				},
				"spacing" : {
					"base" : "8px",
					"lg" : "48px",
					"xs" : "4px",
					"md" : "24px",
					"sm" : "12px",
					"container-max" : "1024px",
					"gutter" : "16px",
					"xl" : "80px"
				},
				"fontFamily" : {
					"headline-md" : [ "Plus Jakarta Sans" ],
					"label-sm" : [ "Plus Jakarta Sans" ],
					"headline-sm" : [ "Plus Jakarta Sans" ],
					"body-sm" : [ "Plus Jakarta Sans" ],
					"label-lg" : [ "Plus Jakarta Sans" ],
					"headline-lg" : [ "Plus Jakarta Sans" ],
					"body-md" : [ "Plus Jakarta Sans" ],
					"body-lg" : [ "Plus Jakarta Sans" ]
				},
				"fontSize" : {
					"headline-md" : [ "24px", {
						"lineHeight" : "1.3",
						"fontWeight" : "700"
					} ],
					"label-sm" : [ "12px", {
						"lineHeight" : "1.2",
						"fontWeight" : "500"
					} ],
					"headline-sm" : [ "20px", {
						"lineHeight" : "1.4",
						"fontWeight" : "600"
					} ],
					"body-sm" : [ "14px", {
						"lineHeight" : "1.5",
						"fontWeight" : "400"
					} ],
					"label-lg" : [ "14px", {
						"lineHeight" : "1.2",
						"letterSpacing" : "0.02em",
						"fontWeight" : "600"
					} ],
					"headline-lg" : [ "32px", {
						"lineHeight" : "1.2",
						"fontWeight" : "700"
					} ],
					"body-md" : [ "16px", {
						"lineHeight" : "1.6",
						"fontWeight" : "400"
					} ],
					"body-lg" : [ "18px", {
						"lineHeight" : "1.6",
						"fontWeight" : "400"
					} ]
				}
			}
		}
	}
</script>
<head>
<meta charset="UTF-8">
<title>Club</title>

<link rel="stylesheet" href="/resources/css/index.css">

<style>
.paging {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 10px;
	margin-top: 40px;
}

.paging a {
	text-decoration: none;
	color: #333;
	padding: 8px 14px;
	border-radius: 8px;
	background: #f5f5f5;
}

.paging a:hover {
	background: #e0e0e0;
}

.active-page {
	background: #ff7a00 !important;
	color: white !important;
}
</style>

</head>

</head>

<body class="bg-background text-on-background min-h-screen">
	<!-- TopNavBar -->
	<header
		class="fixed top-0 w-full z-50 bg-surface/80 backdrop-blur-md border-b border-outline-variant dark:border-outline shadow-sm dark:shadow-none h-16">
		<div
			class="flex justify-between items-center h-full px-gutter max-w-container-max mx-auto">
			<div class="flex items-center gap-base">
				<a
					class="text-headline-md font-headline-md font-bold text-primary dark:text-primary-fixed-dim flex items-center gap-2"
					href="#"> <span class="material-symbols-outlined text-3xl"
					style="font-variation-settings: 'FILL' 1;">eco</span> Kosmo Project
				</a>
				<nav class="hidden md:flex items-center gap-md ml-lg">
					<a
						class="text-on-surface-variant dark:text-surface-variant hover:text-primary font-label-lg text-label-lg transition-all duration-200"
						href="#">Used Goods</a> <a
						class="text-primary dark:text-primary-fixed-dim border-b-2 border-primary pb-1 font-label-lg text-label-lg transition-all duration-200"
						href="/club/list">Clubs</a> <a
						class="text-on-surface-variant dark:text-surface-variant hover:text-primary font-label-lg text-label-lg transition-all duration-200"
						href="#">Real Estate</a> <a
						class="text-on-surface-variant dark:text-surface-variant hover:text-primary font-label-lg text-label-lg transition-all duration-200"
						href="#">Jobs</a>
				</nav>
			</div>
			<div class="flex items-center gap-sm">

				<a href="../member/signUp"
					class="hidden md:block bg-primary text-on-primary px-md py-2 rounded-xl font-label-lg text-label-lg active:scale-95 transform transition-transform shadow-sm">회원가입</a>
				<a href="../member/login"
					class="hidden md:block bg-primary text-on-primary px-md py-2 rounded-xl font-label-lg text-label-lg active:scale-95 transform transition-transform shadow-sm">로그인</a>
			</div>
		</div>
	</header>
	<main class="pt-16 pb-xl">
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
					<a  href="./create"
						class="bg-secondary text-on-secondary px-md py-3 rounded-full font-label-lg text-label-lg flex items-center gap-2 hover:shadow-lg transition-all active:scale-95">
						<span class="material-symbols-outlined">add_circle</span> 모임 만들기
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
				<span class="font-label-lg text-label-lg text-on-surface mr-sm">관심사별로
					찾기:</span> <a href="${pageContext.request.contextPath}/club/list"
					class="px-md py-2 rounded-full ${empty param.clubCategory ? 'bg-primary text-on-primary' : 'bg-surface-container-low text-on-surface-variant'} font-label-lg text-label-lg active:scale-95 transition-all">
					전체 </a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=운동"
					class="px-md py-2 rounded-full ${param.clubCategory eq '운동' ? 'bg-primary text-on-primary' : 'bg-surface-container-low text-on-surface-variant'} font-label-lg text-label-lg hover:bg-surface-container-highest active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">exercise</span>
					운동
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=맛집"
					class="px-md py-2 rounded-full ${param.clubCategory eq '맛집' ? 'bg-primary text-on-primary' : 'bg-surface-container-low text-on-surface-variant'} font-label-lg text-label-lg hover:bg-surface-container-highest active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">restaurant</span>
					맛집
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=여행"
					class="px-md py-2 rounded-full ${param.clubCategory eq '여행' ? 'bg-primary text-on-primary' : 'bg-surface-container-low text-on-surface-variant'} font-label-lg text-label-lg hover:bg-surface-container-highest active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">travel_explore</span>
					여행
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=음악"
					class="px-md py-2 rounded-full ${param.clubCategory eq '음악' ? 'bg-primary text-on-primary' : 'bg-surface-container-low text-on-surface-variant'} font-label-lg text-label-lg hover:bg-surface-container-highest active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">music_note</span>
					음악
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=스터디"
					class="px-md py-2 rounded-full ${param.clubCategory eq '스터디' ? 'bg-primary text-on-primary' : 'bg-surface-container-low text-on-surface-variant'} font-label-lg text-label-lg hover:bg-surface-container-highest active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">school</span>
					스터디
				</a> <a
					href="${pageContext.request.contextPath}/club/list?clubCategory=기타"
					class="px-md py-2 rounded-full ${param.clubCategory eq '기타' ? 'bg-primary text-on-primary' : 'bg-surface-container-low text-on-surface-variant'} font-label-lg text-label-lg hover:bg-surface-container-highest active:scale-95 transition-all flex items-center gap-1">
					<span class="material-symbols-outlined text-[18px]">more_horiz</span>
					기타
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
										class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
								</c:when>

								<c:otherwise>
									<img src="https://via.placeholder.com/600x400?text=No+Image"
										alt="no image"
										class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
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
								<span class="flex items-center text-secondary font-label-lg">
									<span class="w-2 h-2 rounded-full bg-secondary mr-2"></span>
									${dto.currentMember} / ${dto.clubMax}명
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
					<span class="material-symbols-outlined">eco</span> Neighborhood
					Marketplace
				</div>
				<p
					class="font-body-sm text-body-sm text-on-surface-variant opacity-80">©
					2024 Neighborhood Marketplace Inc. Connecting neighbors locally.</p>
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