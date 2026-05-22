package com.club.app.file;

import io.awspring.cloud.s3.S3Template;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class S3Service {

    private final S3Template s3Template;

    @Value("${custom.aws.s3.bucket}")
    private String bucket;

    public String upload(MultipartFile file, String dirName) throws IOException {
        String fileName = dirName + "/" + UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        
        // S3Template을 사용하면 훨씬 간단하게 업로드 가능
        s3Template.upload(bucket, fileName, file.getInputStream());
        
        // 가상 호스팅 스타일 URL 반환
        return "https://" + bucket + ".s3.amazonaws.com/" + fileName;
    }

    public void delete(String fileUrl) {
        if (fileUrl != null && fileUrl.contains(".amazonaws.com/")) {
            String key = fileUrl.substring(fileUrl.indexOf(".amazonaws.com/") + 15);
            s3Template.deleteObject(bucket, key);
        }
    }
}
