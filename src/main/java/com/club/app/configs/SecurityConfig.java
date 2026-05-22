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
                    // 로그인 필요한 페이지
                    .requestMatchers(
                        "/member/update",
                        "/member/detail",
                        "/member/delete",
                        "/member/pwChange",
                        "/member/mypage",
                        "/product/add",
                        "/product/detail",
                        "/product/myList",
                        "/product/delete",
                        "/product/edit",
                        "/product/addFile",
                        "/product/deleteFile",
                        "/job/create",
                        "/job/create/**",
                        "/job/update",
                        "/job/update/**",
                        "/job/delete",
                        "/job/delete/**",
                        "/job/deleteFile",
                        "/job/deleteFile/**",
                        "/job/myJobList",
                        "/jobApply/**",

                        "/restaurant/create",
                        "/restaurant/create/**",

                        "/club/create",
                        "/club/create/**",
                        "/clubSchedule/list",
                        "/clubSchedule/create",
                        "/clubSchedule/create/**",
                        "/productChat/**"
                    ).authenticated()

                    // 모두 허용
                    .requestMatchers(
                        "/",
                        "/member/login",
                        "/member/join",
                        "/product/list",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/files/**"
                    ).permitAll()

                    .anyRequest().permitAll();
            })

            .formLogin(login -> {

                login
                    .loginPage("/member/login")
                    .usernameParameter("memberId")
                    .passwordParameter("memberPw")
                    .loginProcessingUrl("/member/login")
                    .defaultSuccessUrl("/")
                    .failureHandler(loginFailHandler)
                    .permitAll();
            })

            .rememberMe(remember ->

                remember
                    .rememberMeParameter("remember-me")
                    .tokenValiditySeconds(60 * 60 * 24 * 7)
                    .key("myRememberKey")
            )

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