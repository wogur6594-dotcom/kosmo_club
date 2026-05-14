<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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