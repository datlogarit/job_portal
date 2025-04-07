package com.project.jobportal.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobportal.DTOs.CompanyDTO;
import com.project.jobportal.models.Companies;
import com.project.jobportal.services.CompanyService;

import com.project.jobportal.utilities.HandleFile;
import jakarta.validation.Valid;
import lombok.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@RestController
@RequestMapping("api/v1/company")
@RequiredArgsConstructor
public class CompanyController {
    private final CompanyService companyService;
    private final HandleFile handleFile;

    @PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> createCompany(@RequestPart("company") String CompanyJson,//data nhận là String, hài thật chứ
                                           @RequestPart("file") MultipartFile file,
                                           BindingResult result) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        CompanyDTO companyDTO = objectMapper.readValue(CompanyJson, CompanyDTO.class);
        if (result.hasErrors()) {
            List<String> errList = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errList);
        }
        handleFile.validateFile(file);
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                    .body("file isn't image");
        }
        try {
            String fileName = handleFile.storeFile(file, "avtCompany_uploads");
            companyService.crateCompany(companyDTO, fileName);
            return ResponseEntity.ok("create company successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateCompany(@RequestBody @Valid CompanyDTO companyDTO,
                                           @PathVariable long id,
                                           BindingResult result) {
        if (result.hasErrors()) {
            List<String> errList = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errList);
        }
        companyService.updateCompany(id, companyDTO);
        return ResponseEntity.ok("update company successfully with id = " + id);
    }

    @PutMapping("image/{userId}")
    public ResponseEntity<?> uploadAvtCompany(@RequestParam MultipartFile file, @PathVariable long userId) {

        return ResponseEntity.ok("upload avt company successfully");
    }


    @GetMapping("/{id}")
    public ResponseEntity<Companies> getCompanyById(@PathVariable Long id) {
        Companies companies = companyService.getCompanyById(id);
        return ResponseEntity.ok(companies);
    }

    @GetMapping("")
    public ResponseEntity<?> getAllCompany() {
        List<Companies> companies = companyService.getAllCompany();
        return ResponseEntity.ok(companies);
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
        java.nio.file.Path uploadDir = Paths.get("avtCompany_uploads");
        // Kiểm tra và tạo thư mục nếu nó không tồn tại
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        // Đường dẫn đầy đủ đến file
        java.nio.file.Path pathOfFile = Paths.get(uploadDir.toString(), uniqueFilename);
        // Ghi đè khi có file trùng lặp
        Files.copy(file.getInputStream(), pathOfFile, StandardCopyOption.REPLACE_EXISTING);
        return uniqueFilename;
    }

    private boolean isImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");
    }
}
