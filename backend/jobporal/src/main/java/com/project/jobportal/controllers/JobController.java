package com.project.jobportal.controllers;

import com.project.jobportal.DTOs.JobDTO;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.services.JobService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
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

    // ứng với chức năng tìm kiếm, chia job theo category, hiển thị job theo company
    @GetMapping("") // http:localhost:8088/api/v1/job?page=1&limit=10&keyword=frontend
    public ResponseEntity<?> getJobs(
            @RequestParam("page") int page,
            @RequestParam("limit") int limit,
            @RequestParam(value = "search_keyword", required = false) String SearchKeyword,
            @RequestParam(value = "category_id", required = false) Long categoryId,
            @RequestParam(value = "company_id", required = false) Long companyId) {
        Page<Jobs> jobsPage;
        if (SearchKeyword != null && !SearchKeyword.isEmpty()) {
            PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("minSalary").descending());
            jobsPage = jobService.searchJob(SearchKeyword, pageRequest);
        } else if (categoryId != null) {
            PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("minSalary").descending());
            jobsPage = jobService.searchJobByCategory(categoryId, pageRequest);
        } else if (companyId != null) {
            PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("minSalary").descending());
            jobsPage = jobService.searchJobByCompany(companyId, pageRequest);
        } else {
            PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("id").descending());
            jobsPage = jobService.getAllJob(pageRequest);
        }
        int totalPage = jobsPage.getTotalPages();// lấy ra số trang để bắn cho frontend
        return ResponseEntity.ok(jobsPage.getContent());
    }


    @GetMapping("filter")
    public ResponseEntity<?> getJobsByFilter(
            @RequestParam("page") int page,
            @RequestParam("limit") int limit,
            @RequestParam(name = "category", required = false) String category,
            @RequestParam(name = "position", required = false) String position,
            @RequestParam(name = "experience", required = false) String experience,
            @RequestParam(name = "minSalary", required = false) Integer minSalary,
            @RequestParam(name = "maxSalary", required = false) Integer maxSalary) {
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("minSalary").descending());
        List<Jobs> jobsFilter = jobService
                .searchJobByFilter(category, position, experience, minSalary, maxSalary, pageRequest).getContent();
        return ResponseEntity.ok(jobsFilter);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteJob(@PathVariable long id) {
        return ResponseEntity.ok(String.format("delete job with id = %d successfully ", id));
    }
}
