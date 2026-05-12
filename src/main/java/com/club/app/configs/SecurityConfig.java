package com.club.app.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import com.club.app.security.LoginFailHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	private final LoginFailHandler loginFailHandler;
	
	SecurityConfig(LoginFailHandler loginFailHandler) {
		this.loginFailHandler = loginFailHandler;
	}
	
	@Bean
	SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

		http
			.cors(cors -> {
				cors.disable();
			})
			.csrf(csrf -> {
				csrf.disable();				
			})
			.authorizeHttpRequests(auth -> {
				auth
				.requestMatchers("/", "/member/login", "/member/join", "/css/**", "/js/**", "/images/**").permitAll()
				.anyRequest().permitAll()
				;
			})
			.formLogin(login -> {
				login
					.loginPage("/member/login")
					.usernameParameter("memberId")
					.passwordParameter("memberPw")
					.loginProcessingUrl("/member/login")
					.defaultSuccessUrl("/")
					.failureHandler(loginFailHandler)
					.permitAll()
					;
			})
			.logout(logout -> {				
				logout
				.logoutUrl("/member/logout")
				.invalidateHttpSession(true)
				.deleteCookies("JSESSIONID")
				.logoutSuccessUrl("/");
			});
			

		return http.build();
	}
}