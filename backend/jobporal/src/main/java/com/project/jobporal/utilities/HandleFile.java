package com.project.jobporal.utilities;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Objects;
import java.util.UUID;

@Service
public class HandleFile {
    public String storeFile(MultipartFile file, String nameOfFolder) throws IOException {
        String fileName = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        String uniqueName = UUID.randomUUID().toString() + "_" + fileName;
        java.nio.file.Path uploadDir = Paths.get(String.format("%s", nameOfFolder));//tao duong dan den folder
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        //tao duong dan den file
        java.nio.file.Path pathOfFile = Paths.get(uploadDir.toString(), uniqueName);
        Files.copy(file.getInputStream(), pathOfFile, StandardCopyOption.REPLACE_EXISTING);
        return uniqueName;
    }

    public ResponseEntity<?> validateFile(MultipartFile file) {
        if (file.isEmpty() || file.getOriginalFilename() == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("file is null");
        }
        if (file.getSize() > 2 * 1022 * 1024) {
            return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("file is too large");
        }
        return null;
    }
}
