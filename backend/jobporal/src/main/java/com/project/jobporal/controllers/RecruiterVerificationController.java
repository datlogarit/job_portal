package com.project.jobporal.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobporal.DTOs.RecruiterVerificationDTO;
import com.project.jobporal.services.RecruiterVerificationService;
import com.project.jobporal.utilities.HandleFile;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("api/v1/recruiterVerification")
@RestController
@RequiredArgsConstructor
public class RecruiterVerificationController {
    private final RecruiterVerificationService recruiterVerificationService;
    private final HandleFile handleFile;

    @PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> creatRecruiterVerification(
            @RequestPart("verificationInfo") String RecruiterVerificationJson,
            @RequestPart("business_license_url") MultipartFile businessLicense,
            @RequestPart("authorization_letter_url") MultipartFile authorizationLetter
    ) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        RecruiterVerificationDTO recruiterVerificationDTO = objectMapper
                .readValue(RecruiterVerificationJson, RecruiterVerificationDTO.class);
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
            recruiterVerificationService.createRecruiterVerification(recruiterVerificationDTO, fileNameBL, fileNameAl);
            return ResponseEntity.ok("create Recruiter verification successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e);
        }


    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateRecruiterVerification(@PathVariable long id,
                                                         @RequestBody RecruiterVerificationDTO recruiterVerificationDTO) {
        recruiterVerificationService.updateRecruiterVerification(id, recruiterVerificationDTO);
        return ResponseEntity.ok("update Recruiter verification successfully");
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getRecruiterVerificationById(@PathVariable long id,
                                                          @RequestBody RecruiterVerificationDTO recruiterVerificationDTO) {
        return ResponseEntity.ok(recruiterVerificationService.getRecruiterVerificationById(id));
    }

    @GetMapping("")
    public ResponseEntity<?> getAllRecruiterVerification() {
        return ResponseEntity.ok(recruiterVerificationService.getAllRecruiterVerification());
    }
}
