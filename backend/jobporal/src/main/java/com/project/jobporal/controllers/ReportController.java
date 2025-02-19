package com.project.jobporal.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api/v1/report")
public class ReportController {
    @PostMapping("")
    public ResponseEntity<?> createReport() {
        return null;
    }
}
