package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.RecruiterVerificationDTO;
import com.project.jobporal.services.RecruiterVerificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("api/v1/recruiterVerification")
@RestController
@RequiredArgsConstructor
public class RecruiterVerificationController {
    private final RecruiterVerificationService recruiterVerificationService;

    @PostMapping("")
    public ResponseEntity<?> creatRecruiterVerification(@RequestBody RecruiterVerificationDTO recruiterVerificationDTO) {
        recruiterVerificationService.createRecruiterVerification(recruiterVerificationDTO);
        return ResponseEntity.ok("create Recruiter verification successfully");
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
