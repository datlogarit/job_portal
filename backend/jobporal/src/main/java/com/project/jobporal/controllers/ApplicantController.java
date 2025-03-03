package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.User_ApplicantDTO;
import com.project.jobporal.models.Applicants;
import com.project.jobporal.services.ApplicantService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@RequestMapping("api/v1/applicant")
@RestController
@RequiredArgsConstructor
public class ApplicantController {
    private final ApplicantService applicantService;

    @PostMapping("")
    public ResponseEntity<?> createInfoApplicant(@Valid @RequestBody User_ApplicantDTO userApplicantDTO, BindingResult result) {
        if (result.hasErrors()) {
            List<String> listErr = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(listErr);
        }
        applicantService.crateApplicant(userApplicantDTO);
        return ResponseEntity.ok("create application successfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateInfoApplicant(@PathVariable long id,
                                                 @RequestBody @Valid User_ApplicantDTO userApplicantDTO,
                                                 BindingResult result) {
        if (result.hasErrors()) {
            List<String> listErr = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(listErr);
        }
        applicantService.updateApplicant(id, userApplicantDTO);
        return ResponseEntity.ok("update info applicant successfully with id = " + id);
    }

    @PutMapping(value = "resume/{applicantId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateResume(@PathVariable long applicantId,
                                          @RequestParam("file") MultipartFile file) {
        try {
            if (file.isEmpty() || file.getOriginalFilename() == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("file is null");
            }
            if (file.getSize() > 2 * 1022 * 1024) {
                return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("file is too large");
            }
            String fileName = file.getOriginalFilename();

            //chi can file ket thuc la pdf hoac docx
//            -> neu file ket thuc khac pdf va ket thuc khac doxs thi tra loi
            if (!fileName.endsWith(".pdf") && !fileName.endsWith(".docx")) {
                return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE).body("only accept pdf and docx file");
            }
            String newFileName = storeFile(file);

            applicantService.uploadResume(applicantId, newFileName);
            return ResponseEntity.ok("update info applicant successfully with id = " + applicantId);


        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    @GetMapping("/resume/{resumeName}")
    public ResponseEntity<?> viewImage(@PathVariable String resumeName) {
        try {
            java.nio.file.Path imagePath = Paths.get("resumeApplicant/" + resumeName);
            UrlResource resource = new UrlResource(imagePath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.APPLICATION_PDF)
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; file name = " + resumeName)
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("")
    public ResponseEntity<?> getAllApplicant(@RequestParam("page") int page,
                                             @RequestParam("limit") int limit) {
        PageRequest pageRequest1 = PageRequest.of(page, limit, Sort.by("userId").descending());

        Page<Applicants> applicants = applicantService.getAllApplicant(pageRequest1);
        int pageSize = pageRequest1.getPageSize();
        return ResponseEntity.ok(applicants.getContent());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getApplicantById(@PathVariable long id) {
        return ResponseEntity.ok(applicantService.getApplicantById(id));
    }

    private String storeFile(MultipartFile file) throws IOException {
        String fileName = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        String uniqueName = UUID.randomUUID().toString() + "_" + fileName;
        java.nio.file.Path uploadDir = Paths.get("resumeApplicant");//tao duong dan den folder
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        //tao duong dan den file
        java.nio.file.Path pathOfFile = Paths.get(uploadDir.toString(), uniqueName);
        Files.copy(file.getInputStream(), pathOfFile, StandardCopyOption.REPLACE_EXISTING);
        return uniqueName;
    }
}
