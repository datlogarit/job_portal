package com.project.jobportal.controllers;

import com.project.jobportal.DTOs.JobDTO;
import com.project.jobportal.DTOs.RecommenInputDTO;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    //Lấy tất cả các job theo nhà tuyển dụng
    @GetMapping("/recruiter/{recruiterId}")
    public ResponseEntity<?> getJobByRecruiterId(@PathVariable long recruiterId,
                                                 @RequestParam("page") int page,
                                                 @RequestParam("limit") int limit) {
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("createdAt").descending());
        Page<Jobs> jobPage = jobService.getJobByRecruiterId(recruiterId, pageRequest);
        Map<String, Object> response = new HashMap<>();
        response.put("job", jobPage.getContent());
        response.put("total Page", jobPage.getTotalPages());
        response.put("total Element", jobPage.getTotalElements());
        return ResponseEntity.ok(response);
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
            PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("id").ascending());
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

    // lấy  job tương tự khi người dùng nhấn vào job nào đó
    @GetMapping("/sameJob/{jobId}")
    public ResponseEntity<?> getSameJob(@PathVariable(name = "jobId") long jobId) throws Exception {
        return ResponseEntity.ok(jobService.searchSameJobById(jobId));
    }

    //lấy job được hệ thống gợi ý
    @PostMapping("/recommendation")
    public ResponseEntity<?> getRecommendationJob(@RequestBody RecommenInputDTO recommenInputDTO) throws Exception {
        return ResponseEntity.ok(jobService.getRecommendedJob(recommenInputDTO));
    }

    //Xóa job
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteJob(@PathVariable long id) {
        return ResponseEntity.ok(String.format("delete job with id = %d successfully ", id));
    }
}
