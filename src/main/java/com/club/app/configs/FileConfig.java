package com.club.app.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import jakarta.annotation.PostConstruct;

@Configuration
public class FileConfig implements WebMvcConfigurer {

	@Value("${app.upload.base}")
	private String path;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		registry.addResourceHandler("/files/club/**")
        .addResourceLocations("file:///C:/upload/club/");

		registry.addResourceHandler("/clubboard/**")
				.addResourceLocations("file:/C:/upload/clubboard/");
	}
	
	
	@PostConstruct
	public void init() {
		System.out.println("WebConfig 적용됨");
	}
}