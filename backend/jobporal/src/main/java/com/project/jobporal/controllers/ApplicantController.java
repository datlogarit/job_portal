package com.project.jobporal.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("api/v1/user/applicant")
@RestController
public class ApplicantController {
    @PutMapping("")
    public ResponseEntity<?> updateInfoApplicant() {
        return null;
    }
}
