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

<link rel="stylesheet" href="/css/index.css">

</head>

<body id="page-top">

	<c:import url="/WEB-INF/views/temp/topbar.jsp"></c:import>

	<div class="index-main-wrap">

		<!-- HERO -->
		<section class="index-hero-section">

			<div class="row align-items-center">

				<div class="col-lg-7">

					<span class="index-hero-badge"> 동네 생활 서비스 </span>

					<h1 class="index-hero-title">
						우리 동네에서 필요한 일,<br> 한 곳에서 쉽고 빠르게
					</h1>

					<p class="index-hero-text">
						중고거래, 알바 구인구직, 동호회, 동네맛집까지<br> 동네 사람들과 연결되는 생활 서비스를 이용해보세요.
					</p>



				</div>

				<div
					class="col-lg-5 d-flex justify-content-center align-items-center">

					<img src="${pageContext.request.contextPath}/image/logo.png"
						alt="로고" class="index-logo">

				</div>

			</div>

		</section>

		<!-- 서비스 -->
		<section>

			<h2 class="index-section-title">어떤 서비스를 이용할까요?</h2>

			<p class="index-section-desc">가장 자주 사용하는 동네 기능들을 한 화면에서 바로 이동할 수
				있습니다.</p>

			<div class="row">

				<!-- 중고거래 -->
				<div class="col-lg-3 col-md-6 mb-4">

					<a href="/product/list" class="index-service-card-link">

						<div class="index-service-card">

							<div class="index-service-icon">
								<i class="bi bi-bag-check-fill"></i>
							</div>

							<h3 class="index-service-title">중고거래</h3>

							<p class="index-service-text">사용하지 않는 물건을 판매하거나 필요한 물건을 가까운
								동네에서 찾을 수 있습니다.</p>

							<div class="index-service-link">중고거래 페이지 이동 →</div>

						</div>

					</a>

				</div>

				<!-- 알바 -->
				<div class="col-lg-3 col-md-6 mb-4">

					<a href="/job/list" class="index-service-card-link">

						<div class="index-service-card">

							<div class="index-service-icon">
								<i class="bi bi-briefcase-fill"></i>
							</div>

							<h3 class="index-service-title">알바 구인구직</h3>

							<p class="index-service-text">동네 근처 알바 공고를 확인하고 직접 구인 공고도 등록할
								수 있습니다.</p>

							<div class="index-service-link">알바 페이지 이동 →</div>

						</div>

					</a>

				</div>

				<!-- 맛집 -->
				<div class="col-lg-3 col-md-6 mb-4">

					<a href="/restaurant/list" class="index-service-card-link">

						<div class="index-service-card">

							<div class="index-service-icon">
								<i class="bi bi-cup-hot-fill"></i>
							</div>

							<h3 class="index-service-title">동네맛집</h3>

							<p class="index-service-text">우리 동네 맛집을 등록하고 리뷰와 위치 정보를 함께
								확인할 수 있습니다.</p>

							<div class="index-service-link">동네맛집 페이지 이동 →</div>

						</div>

					</a>

				</div>

				<!-- 동호회 -->
				<div class="col-lg-3 col-md-6 mb-4">

					<a href="/club/list" class="index-service-card-link">

						<div class="index-service-card main-service">

							<div class="index-service-icon">
								<i class="bi bi-people-fill"></i>
							</div>

							<h3 class="index-service-title">동호회</h3>

							<p class="index-service-text">운동, 공부, 취미 등 관심사가 비슷한 사람들과 모임을
								만들고 참여할 수 있습니다.</p>

							<div class="index-service-link">동호회 페이지 이동 →</div>

						</div>

					</a>

				</div>

			</div>

		</section>

		<!-- 추가 정보 -->
		<section class="index-info-section">

			<h2 class="index-section-title">이런 기능을 이용할 수 있어요</h2>

			<div class="row">

				<div class="col-md-4 mb-3">

					<div class="index-info-item">

						<i class="bi bi-check-circle-fill"></i> <span> 동네 기반 중고거래 글
							작성 및 조회 </span>

					</div>

				</div>

				<div class="col-md-4 mb-3">

					<div class="index-info-item">

						<i class="bi bi-check-circle-fill"></i> <span> 알바 공고 등록과 지원
							내역 관리 </span>

					</div>

				</div>

				<div class="col-md-4 mb-3">

					<div class="index-info-item">

						<i class="bi bi-check-circle-fill"></i> <span> 동호회 가입 신청,
							게시판, 일정 관리 </span>

					</div>

				</div>

				<div class="col-md-4 mb-3">

					<div class="index-info-item">

						<i class="bi bi-check-circle-fill"></i> <span> 맛집 위치 확인과 리뷰
							등록 </span>

					</div>

				</div>

				<div class="col-md-4 mb-3">

					<div class="index-info-item">

						<i class="bi bi-check-circle-fill"></i> <span> 로그인 회원 중심 권한
							관리 </span>

					</div>

				</div>

				<div class="col-md-4 mb-3">

					<div class="index-info-item">

						<i class="bi bi-check-circle-fill"></i> <span> 우리 동네 생활 정보를
							한 곳에서 확인 </span>

					</div>

				</div>

			</div>

		</section>

		<section class="index-shortcut-section">

			<h2 class="index-section-title">동네 활동 바로가기</h2>

			<p class="index-section-desc">자주 사용하는 기능으로 빠르게 이동할 수 있습니다.</p>

			<div class="row">

				<div class="col-lg-3 col-md-6 mb-4">
					<a href="/clubSchedule/totalList" class="index-shortcut-card">
						<i class="bi bi-calendar-event-fill"></i> <span>전체 일정 보기</span>
					</a>
				</div>

				<div class="col-lg-3 col-md-6 mb-4">
					<a href="/member/mypage" class="index-shortcut-card"> <i
						class="bi bi-person-circle"></i> <span>마이페이지</span>
					</a>
				</div>

				<div class="col-lg-3 col-md-6 mb-4">
					<a href="/jobApply/myList" class="index-shortcut-card"> <i
						class="bi bi-file-earmark-check-fill"></i> <span>내 지원내역</span>
					</a>
				</div>

				<div class="col-lg-3 col-md-6 mb-4">
					<a href="/restaurant/create" class="index-shortcut-card"> <i
						class="bi bi-pencil-square"></i> <span>맛집 등록하기</span>
					</a>
				</div>

			</div>

		</section>

	</div>

	<c:import url="/WEB-INF/views/temp/footer.jsp"></c:import>

	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>

</body>
</html>