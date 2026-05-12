package com.club.app.security;

import java.io.IOException;
import java.net.URLEncoder;

import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class LoginFailHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception)
            throws IOException, ServletException {

        String message = "";
        
		if(exception instanceof AccountExpiredException) {
			// 계정 만료
			message="계정 만료";
		}
		if(exception instanceof LockedException) {
			// 계정 잠김
			message="계정 잠김";
		}
		if(exception instanceof CredentialsExpiredException) {
			// 비번 유효기간 만료
			message="비밀번호 유효기간 만료";
		}
		if(exception instanceof DisabledException) {
			// 휴면 계정
			message="휴면 계정";
		}
		if(exception instanceof InternalAuthenticationServiceException) {
			// ID틀림
			message="존재하지않는 아이디입니다.";
		}
		if(exception instanceof BadCredentialsException) {
			// 비번틀림
			message="비밀번호가 틀렸습니다.";
		}

        message=URLEncoder.encode(message, "UTF-8");
        response.sendRedirect("./login?message="+message);
    }
}
