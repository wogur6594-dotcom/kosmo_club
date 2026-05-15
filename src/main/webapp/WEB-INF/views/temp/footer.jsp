<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<footer class="footer-area">

	<div class="footer-inner">

		<div class="footer-top">

			<div>
				<h4 class="footer-logo">Kosmo Project</h4>

				<p class="footer-desc">
					동네 생활 플랫폼 프로젝트<br>
					중고거래 · 알바 · 동호회 서비스
				</p>
			</div>

			<div class="footer-links">
				<a href="#">중고거래</a>
				<a href="#">알바</a>
				<a href="#">동호회</a>
				<a href="#">고객센터</a>
			</div>

		</div>

		<div class="footer-bottom">
			Copyright © 2026 Kosmo TeamProject
		</div>

	</div>

</footer>

<style>
.footer-area {
	margin-top: 45px;
	background-color: #f4ede5;
	border-top: 1px solid #e5d7c8;
	padding: 25px 20px;
}

.footer-inner {
	max-width: 1180px;
	margin: 0 auto;
}

.footer-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 20px;
}

.footer-logo {
	font-size: 22px;
	font-weight: 900;
	color: #8b4700;
	margin-bottom: 12px;
}

.footer-desc {
	color: #6f5b4c;
	line-height: 1.7;
	margin-bottom: 0;
}

.footer-links {
	display: flex;
	gap: 18px;
	flex-wrap: wrap;
}

.footer-links a {
	color: #8b4700;
	font-weight: 700;
	text-decoration: none;
}

.footer-links a:hover {
	color: #ff7a00;
}

.footer-bottom {
	margin-top: 18px;
	padding-top: 12px;
	border-top: 1px solid #e2d6c9;
	color: #9b8b7c;
	font-size: 14px;
}
</style>