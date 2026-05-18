package com.club.app.configs;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.club.app.club.chat.ClubChatHandler;
import com.club.app.club.chat.ClubChatInterceptor;
import com.club.app.productChat.ProductChatHandler;
import com.club.app.productChat.ProductChatInterceptor;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {

	private final ClubChatHandler clubChatHandler;
	private final ClubChatInterceptor clubChatInterceptor;

	private final ProductChatHandler productChatHandler;

	private final ProductChatInterceptor productChatInterceptor;

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(clubChatHandler, "/ws/clubChat").addInterceptors(clubChatInterceptor)
				.setAllowedOriginPatterns("*");
		
        registry.addHandler(productChatHandler, "/ws/productChat").addInterceptors(productChatInterceptor)
            .setAllowedOriginPatterns("*");

	}
}