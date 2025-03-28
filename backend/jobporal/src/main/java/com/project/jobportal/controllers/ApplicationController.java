package com.project.jobportal.controllers;

import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.services.ApplicationService;
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

    @PutMapping("/{applicantId}/{jobId}")
    public ResponseEntity<?> updateApplication(@PathVariable long applicantId, @PathVariable long jobId,
                                               @RequestBody ApplicationDTO applicationDTO) {
        applicationService.updateApplication(applicantId, jobId, applicationDTO);
        return ResponseEntity.ok(String.format("update application successfully with applicantId = %d and jobId = %d", applicantId, jobId));
    }

    @PutMapping("/save/{applicantId}/{jobId}")
    public ResponseEntity<?> updateSaveApplication(@PathVariable long applicantId, @PathVariable long jobId,
                                                   @RequestBody ApplicationDTO applicationDTO) {
        applicationService.updateSaveApplication(applicantId, jobId, applicationDTO);
        return ResponseEntity.ok(String.format("update save application successfully with applicantId = %d and jobId = %d", applicantId, jobId));
    }

    @GetMapping("/info")
    public ResponseEntity<?> getApplicationById(@RequestParam("applicantId") long applicantId,
                                                @RequestParam("jobId") long jobId) {
        return ResponseEntity.ok(applicationService.findByApplicantIdAndJobId(applicantId, jobId));
    }

    @GetMapping("")
    public ResponseEntity<?> getAllApplication(@RequestParam("page") int page,
                                               @RequestParam("limit") int limit) {
        PageRequest pageRequest1 = PageRequest.of(page, limit, Sort.by("createdAt").descending());
        return ResponseEntity.ok(applicationService.getAllApplication(pageRequest1).getContent());
    }
}
