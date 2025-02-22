package com.project.jobporal.controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.jobporal.DTOs.ReportDTO;
import com.project.jobporal.services.ReportService;

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

    @PutMapping("/{id}") // update trường isSolve - cho admin
    public ResponseEntity<?> updateReport(@PathVariable long id, @RequestBody ReportDTO reportDTO) {
        reportService.updateReport(id, reportDTO);
        return ResponseEntity.ok("Update report successfully");
    }
}
