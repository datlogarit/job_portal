package com.project.jobportal.controllers;

import com.project.jobportal.DTOs.UserDTO;
import com.project.jobportal.DTOs.User_ApplicantDTO;
import com.project.jobportal.components.JwtUtil;
import com.project.jobportal.models.Applicants;
import com.project.jobportal.response.LoginResponse;
import com.project.jobportal.services.ApplicantService;
import com.project.jobportal.utilities.HandleFile;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Paths;
import java.util.List;

@RequestMapping("api/v1/applicant")
@RestController
@RequiredArgsConstructor
public class ApplicantController {
    private final ApplicantService applicantService;
    private final HandleFile handleFile;

//    @PostMapping("/login")
//    public ResponseEntity<?> login(@RequestBody UserDTO userDTO) {
//        LoginResponse jwtResponse = applicantService.login(userDTO.getEmail(), userDTO.getPassword());
//        return ResponseEntity.ok(jwtResponse);
//    }

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
                                                 @RequestBody User_ApplicantDTO userApplicantDTO,
                                                 BindingResult result) {
//        if (result.hasErrors()) {
//            List<String> listErr = result.getFieldErrors()
//                    .stream()
//                    .map(FieldError::getDefaultMessage)
//                    .toList();
//            return ResponseEntity.badRequest().body(listErr);
//        }

        return ResponseEntity.ok(applicantService.updateApplicant(id, userApplicantDTO));
    }

    @PutMapping(value = "resume/{applicantId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateResume(@PathVariable long applicantId,
                                          @RequestParam("file") MultipartFile file) {
        try {
            handleFile.validateFile(file);
            String fileName = file.getOriginalFilename();

            //chi can file ket thuc la pdf hoac docx
//            -> neu file ket thuc khac pdf va ket thuc khac doxs thi return response;
            if (!fileName.endsWith(".pdf") && !fileName.endsWith(".docx")) {
                return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE).body("only accept pdf and docx file");
            }
            String newFileName = handleFile.storeFile(file, "resumeApplicant");

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

    @GetMapping("/recommendApplicant/{jobId}")
    public ResponseEntity<?> recommendedApplicantByJobId(@PathVariable long jobId) throws Exception {
        return ResponseEntity.ok(applicantService.recommendApplicantByJobId(jobId));
    }

    @GetMapping("/numberApplicant")
    public ResponseEntity<?> totalApplicant() throws Exception {
        return ResponseEntity.ok(applicantService.countTotalApplicant());
    }
}
