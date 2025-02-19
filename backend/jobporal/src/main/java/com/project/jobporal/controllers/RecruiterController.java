package com.project.jobporal.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/recruiter")
public class RecruiterController {
    @GetMapping("")
    public ResponseEntity<?> updateInfoRecruiter() {
        return null;
    }
}
