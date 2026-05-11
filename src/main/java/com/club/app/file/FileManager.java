package com.club.app.file;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManager {

	@Value("${app.upload.base}")
	private String path;

	public boolean fileDelete(String name, FileDTO fileDTO) throws Exception {
		File file = new File(path, name); // C:/upload/notice
		file = new File(file, fileDTO.getFileName()); // ***./jpg 파일명

		return file.delete();

	}

	public String fileSave(String name, MultipartFile mf) throws Exception {
		// 이미지 검사
		if (!mf.getContentType().startsWith("image")) {

			throw new Exception("이미지 파일만 가능");
		}
		// 1. 저장 위치
		File file = new File(path, name);
		if (!file.exists()) {
			file.mkdirs();
		}

		// 2. 파일명, 확장자
		String fileName = UUID.randomUUID().toString();
		fileName = fileName + "_" + mf.getOriginalFilename();

		file = new File(file, fileName);

		// 3. 저장
		FileCopyUtils.copy(mf.getBytes(), file);

		return fileName;

	}

}
