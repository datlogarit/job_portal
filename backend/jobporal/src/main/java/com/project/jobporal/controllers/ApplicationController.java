package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.ApplicationDTO;
import com.project.jobporal.services.ApplicationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/application")
@RequiredArgsConstructor
public class ApplicationController {
    private final ApplicationService applicationService;

    @PostMapping("")
    public ResponseEntity<?> createApplication(@RequestBody ApplicationDTO applicationDTO) {
        applicationService.createApplication(applicationDTO);
        return ResponseEntity.ok("create applicant successfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateApplication(@PathVariable long id, @RequestBody ApplicationDTO applicationDTO) {
        applicationService.updateApplication(id, applicationDTO);
        return ResponseEntity.ok("update applicant successfully with id = " + id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getApplicationById(@PathVariable long id) {
        return ResponseEntity.ok(applicationService.getApplicationById(id));
    }

    @GetMapping("")
    public ResponseEntity<?> getAllApplication(@RequestParam("page") int page,
                                               @RequestParam("limit") int limit) {
        PageRequest pageRequest1 = PageRequest.of(page, limit, Sort.by("createdAt").descending());
        return ResponseEntity.ok(applicationService.getAllApplication(pageRequest1).getContent());
    }
}
