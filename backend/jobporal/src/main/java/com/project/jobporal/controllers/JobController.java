package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.JobDTO;
import com.project.jobporal.models.Jobs;
import com.project.jobporal.services.JobService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/job")
@RequiredArgsConstructor
public class JobController {
    private final JobService jobService;

    @PostMapping("")
    public ResponseEntity<?> createJob(@RequestBody @Valid JobDTO jobDTO, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errList = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errList);
        }
        jobService.createJob(jobDTO);
        return ResponseEntity.ok("create job successfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateJob(@PathVariable long id, @RequestBody @Valid JobDTO jobDTO, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errList = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errList);
        }
        jobService.updateJob(id, jobDTO);
        return ResponseEntity.ok("update job successfully with id = " + id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getJobById(@PathVariable long id) {
        return ResponseEntity.ok(jobService.getJobById(id));
    }

    @GetMapping("") // http:localhost:8088/api/v1/job?page=1&limit=10&keyword=frontend
    public ResponseEntity<?> getAllJob(@RequestParam("page") int page,
            @RequestParam("limit") int limit,
            @RequestParam(value = "keyword", required = false) String keyword) {
        List<Jobs> jobs;
        if (keyword != null && !keyword.isEmpty()) {// nếu có keyword -> trả về tất job contain keyword
            jobs = jobService.searchJob(keyword);
        } else {
            jobs = jobService.getAllJob();
        }

        return ResponseEntity.ok(jobs);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteJob(@PathVariable long id) {
        return ResponseEntity.ok(String.format("delete job with id = %d successfully ", id));
    }
}
