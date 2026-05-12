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
		File file = new File(path, name); // C:/upload/
		file = new File(file, fileDTO.getFileName()); // ***./jpg 파일명

		return file.delete();

	}

	public String fileSave(String name, MultipartFile mf) throws Exception {

		if (!mf.getContentType().startsWith("image")) {
			throw new Exception("이미지 파일만 가능");
		}

		File file = new File(path, name);

		System.out.println("저장 폴더 경로: " + file.getAbsolutePath());

		if (!file.exists()) {
			file.mkdirs();
		}

		String fileName = UUID.randomUUID().toString();
		fileName = fileName + "_" + mf.getOriginalFilename();

		file = new File(file, fileName);

		System.out.println("저장 파일 경로: " + file.getAbsolutePath());

		FileCopyUtils.copy(mf.getBytes(), file);

		return fileName;
	}

}
