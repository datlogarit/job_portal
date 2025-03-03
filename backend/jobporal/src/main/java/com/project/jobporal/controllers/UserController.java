package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.User_RecruiterDTO;
import com.project.jobporal.services.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Objects;
import java.util.UUID;

@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    //quyen cua tat ca user
    @PostMapping("")
    public ResponseEntity<?> register(@RequestBody @Valid User_RecruiterDTO userDTO, BindingResult result) {

        return null;
    }

    @GetMapping("login")
    public ResponseEntity<?> login(String token) {
        return null;
    }

    //cac quyen cua admin
    //sua doi trang thai (active)
    @PutMapping("active")
    public ResponseEntity<?> updateApplicant() {
        return null;
    }

    @PutMapping(value = "image/{userId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    //chỉ định chỉ nhận dữ liệu kiểu multipart - from data
    public ResponseEntity<?> updateImgUser(@PathVariable long userId,
                                           @RequestParam("file") MultipartFile file) {

        if (file.getSize() == 0) {//lay ra kich thuoc file
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("file is empty");
        }
        if (file.getSize() > 2 * 1024 * 1024) { // Kích thước > 2MB
            return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
                    .body("file is too large");
        }
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                    .body("file isn't image");
        }
        try {
            String fileName = storeFile(file);
            userService.uploadAvt(userId, fileName);
            return ResponseEntity.ok("upload file successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e);
        }

        //xu ly file
        /*
        1. ktra xem no co phai file anh ko
        2. ktra xem user co truyen file khong (size != 0)
        2. ktra dung luong (khong vuot qua 2MB)
        3. doi ten file (tranh trung lap)
        4. luu file vao thu muc upload tren server
        5. luu ten file len db
         */

    }

    @GetMapping("/images/{imageName}")
    public ResponseEntity<?> viewImage(@PathVariable String imageName) {
        try {
            java.nio.file.Path imagePath = Paths.get("avtUser_uploads/" + imageName);
            UrlResource resource = new UrlResource(imagePath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("")
    public ResponseEntity<?> getAllUser() {
        return null;
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable long id) {
        return null;
    }


    private String storeFile(MultipartFile file) throws IOException {
        if (!isImageFile(file) || file.getOriginalFilename() == null) {
            throw new IOException("Invalid image format");
        }
        //lấy tên file, xử lý các ký tự không hợp lệ
        String filename = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        // Thêm UUID vào trước tên file để đảm bảo tên file là duy nhất
        String uniqueFilename = UUID.randomUUID().toString() + "_" + filename;
        // Đường dẫn đến thư mục mà bạn muốn lưu file
        java.nio.file.Path uploadDir = Paths.get("avtUser_uploads");
        // Kiểm tra và tạo thư mục nếu nó không tồn tại
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        // Đường dẫn đầy đủ đến file
        java.nio.file.Path patOfFile = Paths.get(uploadDir.toString(), uniqueFilename);
        // Ghi đè khi có file trùng lặp
        Files.copy(file.getInputStream(), patOfFile, StandardCopyOption.REPLACE_EXISTING);
        return uniqueFilename;
    }

    private boolean isImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");
    }
}



