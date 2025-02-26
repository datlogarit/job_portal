package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.User_ApplicantDTO;
import com.project.jobporal.models.Applicants;
import com.project.jobporal.services.ApplicantService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("api/v1/applicant")
@RestController
@RequiredArgsConstructor
public class ApplicantController {
    private  final ApplicantService applicantService;
    @PostMapping("")
    public ResponseEntity<?> createInfoApplicant(@RequestBody User_ApplicantDTO userApplicantDTO){
        applicantService.crateApplicant(userApplicantDTO);
        return ResponseEntity.ok("create application successfully");

    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateInfoApplicant(@PathVariable long id, @RequestBody User_ApplicantDTO userApplicantDTO) {
        applicantService.updateApplicant(id, userApplicantDTO);
        return ResponseEntity.ok("update info applicant successfully with id = "+ id);
    }

    @GetMapping("")
    public ResponseEntity<?> getAllApplicant(@RequestParam("page") int page,
                                             @RequestParam("limit") int limit){
        PageRequest pageRequest1 = PageRequest.of(page, limit, Sort.by("userId").descending());

        Page<Applicants> applicants = applicantService.getAllApplicant(pageRequest1);
        int pageSize = pageRequest1.getPageSize();
        return ResponseEntity.ok(applicants.getContent());
    }
    @GetMapping("/{id}")
    public ResponseEntity<?> getApplicantById(@PathVariable long id){
        return ResponseEntity.ok(applicantService.getApplicantById(id));
    }
}
