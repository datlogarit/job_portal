package com.project.jobportal.controllers;


import com.project.jobportal.DTOs.UserDTO;
import com.project.jobportal.services.UserService;
import com.project.jobportal.utilities.HandleFile;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Paths;

@RestController
@RequestMapping("api/v1/user")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final HandleFile handleFile;

    @PostMapping("login/{role}")
    public ResponseEntity<?> login(@RequestBody UserDTO userDTO, @PathVariable("role") String role) {
        return ResponseEntity.ok(userService.login(userDTO.getEmail(), userDTO.getPassword(), role));
    }

    @PutMapping("/{userId}")
    public ResponseEntity<?> updateApplicantById(@PathVariable(name = "userId") long id, @RequestBody UserDTO userDTO
    ) throws IOException {
        userService.updateUserByID(userDTO, id);
        return ResponseEntity.ok("update status successfully");
    }

    @PutMapping("active/{userId}/{status}")
    public ResponseEntity<?> updateStatusApplicant(@PathVariable(name = "userId") long id,
                                                   @PathVariable(name = "status") int status) {
        userService.updateStatusUser(id, status);
        return ResponseEntity.ok("update status successfully");
    }

    @PutMapping(value = "image/{userId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    //chỉ định chỉ nhận dữ liệu kiểu multipart - from data
    public ResponseEntity<?> updateImgUser(@PathVariable long userId,
                                           @RequestParam("file") MultipartFile file) {

//        if (file.getSize() == 0) {//lay ra kich thuoc file
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
//                    .body("file is empty");
//        }
//        if (file.getSize() > 2 * 1024 * 1024) { // Kích thước > 2MB
//            return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
//                    .body("file is too large");
//        }

        handleFile.validateFile(file);
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                    .body("file isn't image");
        }
        try {
            String fileName = handleFile.storeFile(file, "avtUser_uploads");
            userService.uploadAvt(userId, fileName);
            return ResponseEntity.ok("upload file successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e);
        }
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

    //    @GetMapping("")
//    public ResponseEntity<?> getAllUser() {
//        return null;
//    }
//
    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable long id) {

        return ResponseEntity.ok(userService.getUserById(id));
    }
}



