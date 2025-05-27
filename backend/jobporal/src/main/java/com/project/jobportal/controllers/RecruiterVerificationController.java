package com.project.jobportal.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobportal.DTOs.RecruiterVerificationDTO;
import com.project.jobportal.services.RecruiterVerificationService;
import com.project.jobportal.utilities.HandleFile;
import com.project.jobportal.utilities.helper;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

@RequestMapping("api/v1/recruiterVerification")
@RestController
@RequiredArgsConstructor
public class RecruiterVerificationController {
    private final RecruiterVerificationService recruiterVerificationService;
    private final HandleFile handleFile;

    @PostMapping(value = "/{recruiterId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> creteRecruiterVerification(
            @PathVariable(value = "recruiterId") long recruiterId,
            @RequestPart(value = "business_license_url") MultipartFile businessLicense,
            @RequestPart(value = "authorization_letter_url") MultipartFile authorizationLetter
    ) throws Exception {
//        ObjectMapper objectMapper = new ObjectMapper();
//        RecruiterVerificationDTO recruiterVerificationDTO = objectMapper
//                .readValue(RecruiterVerificationJson, RecruiterVerificationDTO.class);
        if (businessLicense.getSize() == 0 || businessLicense.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("business license is empty");
        }
        if (authorizationLetter.getSize() == 0 || authorizationLetter.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("authorization letter is empty");
        }
        if (businessLicense.getSize() > 2 * 1024 * 1024 || authorizationLetter.getSize() > 2 * 1024 * 1024) {
            return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("Maximum file size is 2MB");
        }

        if ((!businessLicense.getOriginalFilename().endsWith(".pdf") && !businessLicense.getOriginalFilename().endsWith(".docx"))
                || (!authorizationLetter.getOriginalFilename().endsWith(".pdf") && !authorizationLetter.getOriginalFilename().endsWith(".docx"))) {
            return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                    .body("file must be pdf or docx file");
        }
        try {
            String fileNameBL = handleFile.storeFile(businessLicense, "businessLicense");
            String fileNameAl = handleFile.storeFile(authorizationLetter, "authorizationLetter");
            recruiterVerificationService.createRecruiterVerification(recruiterId, fileNameBL, fileNameAl);
            return ResponseEntity.ok("create Recruiter verification successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e);
        }
    }

    @PutMapping(value = "/{verifyId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updateRecruiterVerification(
            @PathVariable(value = "verifyId") long verifyId,
            @RequestPart(value = "business_license_url") MultipartFile businessLicense,
            @RequestPart(value = "authorization_letter_url") MultipartFile authorizationLetter
    ) throws Exception {
        if (businessLicense.getSize() == 0 || businessLicense.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("business license is empty");
        }
        if (authorizationLetter.getSize() == 0 || authorizationLetter.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("authorization letter is empty");
        }
        if (businessLicense.getSize() > 2 * 1024 * 1024 || authorizationLetter.getSize() > 2 * 1024 * 1024) {
            return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE).body("Maximum file size is 2MB");
        }

        if ((!businessLicense.getOriginalFilename().endsWith(".pdf") && !businessLicense.getOriginalFilename().endsWith(".docx"))
                || (!authorizationLetter.getOriginalFilename().endsWith(".pdf") && !authorizationLetter.getOriginalFilename().endsWith(".docx"))) {
            return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                    .body("file must be pdf or docx file");
        }
        try {
            String fileNameBL = handleFile.storeFile(businessLicense, "businessLicense");
            String fileNameAl = handleFile.storeFile(authorizationLetter, "authorizationLetter");
            recruiterVerificationService.updateRecruiterVerification(verifyId, fileNameBL, fileNameAl);
            return ResponseEntity.ok("update Recruiter verification successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e);
        }
    }

//    @PutMapping("/{id}")
//    public ResponseEntity<?> updateRecruiterVerification(@PathVariable long id,
//                                                         @RequestBody RecruiterVerificationDTO recruiterVerificationDTO) {
//        recruiterVerificationService.updateRecruiterVerification(id, recruiterVerificationDTO);
//        return ResponseEntity.ok("update Recruiter verification successfully");
//    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getRecruiterVerificationById(@PathVariable long id,
                                                          @RequestBody RecruiterVerificationDTO recruiterVerificationDTO) {
        return ResponseEntity.ok(recruiterVerificationService.getRecruiterVerificationById(id));
    }

    @GetMapping("")
    public ResponseEntity<?> getAllRecruiterVerification() {
        return ResponseEntity.ok(recruiterVerificationService.getAllRecruiterVerification());
    }

    @PutMapping("status")
    public ResponseEntity<?> updateStatus(@RequestParam("verifyId") long verifyId, @RequestParam("status") int status) {
        recruiterVerificationService.updateStatusVerify(verifyId, status);
        return ResponseEntity.ok("update successfully");
    }

    @GetMapping("/LOA/{resumeName}")
    public ResponseEntity<byte[]> getLOA(@PathVariable String resumeName) throws IOException {
        File resumeFile = new File("authorizationLetter/" + resumeName);

        if (!resumeFile.exists()) {
            return ResponseEntity.notFound().build();
        }

        // Kiểm tra phần mở rộng
        String lowerName = resumeName.toLowerCase();
        byte[] fileContent;
        File fileToReturn;

        if (lowerName.endsWith(".docx") || lowerName.endsWith(".doc")) {
            // Nếu là file docx → chuyển sang pdf
            File pdfFile = helper.convertWordToPdf(resumeFile);
            fileContent = Files.readAllBytes(pdfFile.toPath());

            // Sau khi đọc xong thì xóa file pdf tạm thời
            pdfFile.delete();

            fileToReturn = pdfFile;
        } else if (lowerName.endsWith(".pdf")) {
            // Nếu là file PDF → đọc luôn
            fileContent = Files.readAllBytes(resumeFile.toPath());
            fileToReturn = resumeFile;
        } else {
            // Không hỗ trợ định dạng khác
            return ResponseEntity
                    .badRequest()
                    .body(("Unsupported file type: " + resumeName).getBytes(StandardCharsets.UTF_8));
        }

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileToReturn.getName() + "\"")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(fileContent.length)
                .body(fileContent);
    }

    @GetMapping("/BL/{resumeName}")
    public ResponseEntity<byte[]> getBL(@PathVariable String resumeName) throws IOException {
        File resumeFile = new File("businessLicense/" + resumeName);

        if (!resumeFile.exists()) {
            return ResponseEntity.notFound().build();
        }

        // Kiểm tra phần mở rộng
        String lowerName = resumeName.toLowerCase();
        byte[] fileContent;
        File fileToReturn;

        if (lowerName.endsWith(".docx") || lowerName.endsWith(".doc")) {
            // Nếu là file docx → chuyển sang pdf
            File pdfFile = helper.convertWordToPdf(resumeFile);
            fileContent = Files.readAllBytes(pdfFile.toPath());

            // Sau khi đọc xong thì xóa file pdf tạm thời
            pdfFile.delete();

            fileToReturn = pdfFile;
        } else if (lowerName.endsWith(".pdf")) {
            // Nếu là file PDF → đọc luôn
            fileContent = Files.readAllBytes(resumeFile.toPath());
            fileToReturn = resumeFile;
        } else {
            // Không hỗ trợ định dạng khác
            return ResponseEntity
                    .badRequest()
                    .body(("Unsupported file type: " + resumeName).getBytes(StandardCharsets.UTF_8));
        }

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileToReturn.getName() + "\"")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(fileContent.length)
                .body(fileContent);
    }
}
