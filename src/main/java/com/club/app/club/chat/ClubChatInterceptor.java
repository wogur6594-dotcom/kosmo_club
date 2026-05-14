package com.club.app.club.chat;

import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;
import org.springframework.web.util.UriComponentsBuilder;

import com.club.app.member.MemberDTO;

@Component
public class ClubChatInterceptor implements HandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
			WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {

		String query = request.getURI().getQuery();

		String clubNum = UriComponentsBuilder.fromUri(request.getURI())
			.build()
			.getQueryParams()
			.getFirst("clubNum");

		if (clubNum == null) {
			return false;
		}

		Authentication authentication =
			(Authentication) request.getPrincipal();

		if (authentication == null || authentication.getPrincipal().equals("anonymousUser")) {
			return false;
		}

		MemberDTO memberDTO = (MemberDTO) authentication.getPrincipal();

		attributes.put("clubNum", Long.parseLong(clubNum));
		attributes.put("memberNum", memberDTO.getMemberNum());
		attributes.put("memberName", memberDTO.getMemberName());

		return true;
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
			WebSocketHandler wsHandler, Exception exception) {
	}
}