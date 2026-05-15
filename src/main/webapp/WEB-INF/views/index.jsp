<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네 생활 플랫폼</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
body {
	background-color: #fff8f2;
	color: #2d2118;
}

.main-wrap {
	max-width: 1180px;
	margin: 0 auto;
	padding: 45px 20px 70px;
}

.hero-section {
	background: linear-gradient(135deg, #fff0df, #fff8f2);
	border-radius: 32px;
	padding: 10px 55px;
	box-shadow: 0 8px 24px rgba(120, 80, 40, 0.08);
	margin-bottom: 55px;
}

.hero-badge {
	display: inline-block;
	background-color: #ffe2c4;
	color: #b45f00;
	font-weight: 800;
	border-radius: 999px;
	padding: 8px 18px;
	margin-bottom: 20px;
}

.hero-title {
	font-size: 40px;
	font-weight: 900;
	line-height: 1.35;
	margin-bottom: 20px;
	color: #2d2118;
}

.hero-text {
	font-size: 18px;
	color: #6b5748;
	line-height: 1.7;
	margin-bottom: 32px;
}

.btn-main {
	background-color: #ff7a00;
	color: white;
	border-radius: 16px;
	padding: 13px 26px;
	font-weight: 800;
	border: none;
}

.btn-main:hover {
	background-color: #e86e00;
	color: white;
	text-decoration: none;
}

.btn-sub {
	background-color: white;
	color: #8a4b12;
	border-radius: 16px;
	padding: 13px 24px;
	font-weight: 800;
	border: 1px solid #ead1bb;
	margin-left: 8px;
}

.btn-sub:hover {
	background-color: #fff3e8;
	color: #8a4b12;
	text-decoration: none;
}

.section-title {
	font-size: 27px;
	font-weight: 900;
	margin-bottom: 12px;
}

.section-desc {
	color: #7a6657;
	margin-bottom: 28px;
}

.service-card {
	background-color: white;
	border-radius: 26px;
	padding: 32px 28px;
	height: 100%;
	box-shadow: 0 6px 18px rgba(120, 80, 40, 0.08);
	transition: 0.25s;
	border: 1px solid #f1dfd0;
}

.service-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 12px 28px rgba(120, 80, 40, 0.13);
}

.service-card.main-service {
	border: 2px solid #ffb36b;
}

.service-icon {
	width: 64px;
	height: 64px;
	border-radius: 20px;
	background-color: #fff0df;
	color: #ff7a00;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 31px;
	margin-bottom: 23px;
}

.service-title {
	font-size: 22px;
	font-weight: 900;
	margin-bottom: 12px;
}

.service-text {
	color: #6f5b4c;
	line-height: 1.65;
	min-height: 82px;
}

.service-link {
	display: inline-block;
	margin-top: 18px;
	color: #ff7a00;
	font-weight: 900;
}

.service-link:hover {
	color: #d96500;
	text-decoration: none;
}

.info-section {
	margin-top: 55px;
	background-color: white;
	border-radius: 26px;
	padding: 34px;
	box-shadow: 0 6px 18px rgba(120, 80, 40, 0.07);
}

.info-item {
	display: flex;
	align-items: center;
	margin-bottom: 14px;
	color: #5f4b3b;
}

.info-item i {
	color: #ff7a00;
	margin-right: 12px;
	font-size: 20px;
}

.main-logo {
	max-width: 460px;
	width: 100%;
	object-fit: contain;
	filter: drop-shadow(0 10px 18px rgba(0,0,0,0.08));
}
</style>
</head>

<body id="page-top">

	<div id="wrapper">

		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">

				<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

				<div class="main-wrap">

					<section class="hero-section">

						<div class="row align-items-center">

							<!-- 왼쪽 텍스트 -->
							<div class="col-lg-7">

								<span class="hero-badge">동네 생활 서비스</span>

								<h1 class="hero-title">
									우리 동네에서 필요한 일,<br> 한 곳에서 쉽고 빠르게
								</h1>

								<p class="hero-text">
									중고거래부터 알바 구인구직, 동호회 모임까지<br> 동네 사람들과 연결되는 생활 서비스를 이용해보세요.
								</p>

								

							</div>

							<!-- 오른쪽 로고 -->
<div class="col-lg-5 d-flex justify-content-center align-items-center">

	<img src="${pageContext.request.contextPath}/image/logo.png"
		alt="로고" class="main-logo">

</div>

						</div>

					</section>

					<section>
						<h2 class="section-title">어떤 서비스를 이용할까요?</h2>
						<p class="section-desc">가장 자주 쓰는 동네 기능들을 한 화면에서 바로 이동할 수 있습니다.
						</p>

						<div class="row">

							<div class="col-md-4 mb-4">
								<div class="service-card">
									<div class="service-icon">
										<i class="bi bi-bag-check-fill"></i>
									</div>

									<h3 class="service-title">중고거래</h3>

									<p class="service-text">사용하지 않는 물건을 판매하거나, 필요한 물건을 가까운 동네에서
										찾아볼 수 있습니다.</p>

									<a href="${pageContext.request.contextPath}/product/list"
										class="service-link"> 중고거래 페이지 이동 → </a>
								</div>
							</div>

							<div class="col-md-4 mb-4">
								<div class="service-card">
									<div class="service-icon">
										<i class="bi bi-briefcase-fill"></i>
									</div>

									<h3 class="service-title">알바 구인구직</h3>

									<p class="service-text">동네 근처 알바 공고를 확인하고, 필요한 인원을 모집할 수
										있습니다.</p>

									<a href="${pageContext.request.contextPath}/job/list"
										class="service-link"> 알바 페이지 이동 → </a>
								</div>
							</div>

							<div class="col-md-4 mb-4">
								<div class="service-card">
									<div class="service-icon">
										<i class="bi bi-people-fill"></i>
									</div>

									<h3 class="service-title">동호회</h3>

									<p class="service-text">운동, 맛집, 공부, 취미 등 관심사가 비슷한 사람들과 동네
										모임을 만들고 참여할 수 있습니다.</p>

									<a href="${pageContext.request.contextPath}/club/list"
										class="service-link"> 동호회 페이지 이동 → </a>
								</div>
							</div>

						</div>
					</section>

					<section class="info-section">
						<h2 class="section-title">또 뭐만들지</h2>

						<div class="info-item">
							<i class="bi bi-check-circle-fill"></i> <span>뉴스?</span>
						</div>

						<div class="info-item">
							<i class="bi bi-check-circle-fill"></i> <span>에러뜨면 머리ㅈㄴ아픈데</span>
						</div>

						<div class="info-item mb-0">
							<i class="bi bi-check-circle-fill"></i> <span>다되면 GPT 넣는정도?</span>
						</div>
					</section>

				</div>

			</div>
		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>
</body>
</html>