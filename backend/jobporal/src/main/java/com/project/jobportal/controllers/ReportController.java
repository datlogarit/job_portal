package com.project.jobportal.controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import com.project.jobportal.DTOs.ReportDTO;
import com.project.jobportal.services.ReportService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/report")
public class ReportController {
    private final ReportService reportService;

    @PostMapping("")
    public ResponseEntity<?> createReport(@RequestBody @Valid ReportDTO reportDTO, BindingResult result) {
        if (result.hasErrors()) {
            List<String> listErr = result
                    .getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(listErr);

        }
        reportService.createReport(reportDTO);
        return ResponseEntity.ok("Insert report successfully");
    }

    @GetMapping("")
    public ResponseEntity<?> getAllReports() {
        return ResponseEntity.ok(reportService.getAllReport());
    }

    @PutMapping("") // update trường isSolve - cho admin
    public ResponseEntity<?> updateStatusReport(@RequestParam("reportId") long reportId,
                                                @RequestParam("statusSolve") long statusSolve) {
        reportService.updateStatusReport(reportId, statusSolve);
        return ResponseEntity.ok("Update report successfully");
    }

    @PutMapping("/BANUser") //BAN user
    public ResponseEntity<?> banUser(
            @RequestParam("reportId") Long reportId) {
        reportService.banUser(reportId);
        return ResponseEntity.ok("BAN user successfully");
    }

    @PutMapping("/BANPost") //BAN post
    public ResponseEntity<?> banPost(
            @RequestParam("reportId") Long reportId) {
        reportService.banPost(reportId);
        return ResponseEntity.ok("BAN post successfully");
    }

    @GetMapping("/totalReportPending")
    public ResponseEntity<?> totalReport() throws Exception {
        return ResponseEntity.ok(reportService.countTotalReportPending());
    }
}
