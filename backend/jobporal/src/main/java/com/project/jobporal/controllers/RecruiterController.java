package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.User_RecruiterDTO;
import com.project.jobporal.services.RecruiterService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/recruiter")
@RequiredArgsConstructor
public class RecruiterController {
    private final RecruiterService recruiterService;

    @PostMapping("")
    public ResponseEntity<?> createInfoRecruiter(@RequestBody User_RecruiterDTO userRecruiterDTO) {
        recruiterService.createRecruiter(userRecruiterDTO);
        return ResponseEntity.ok("create recruiter successfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateInfoRecruiter(@PathVariable long id, @RequestBody User_RecruiterDTO userRecruiterDTO) {
        recruiterService.updateRecruiter(id, userRecruiterDTO);
        return ResponseEntity.ok("update recruiter successfully with id = " + id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getRecruiterByid(@PathVariable long id) {
        return ResponseEntity.ok(recruiterService.getRecruiter(id));
    }

    @GetMapping("")
    public ResponseEntity<?> getAllRecruiter(@RequestParam("page") int page,
                                             @RequestParam("limit") int limit) {
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("userId"));
        return ResponseEntity.ok(recruiterService.getAllRecruiters(pageRequest).getContent());
    }
}
