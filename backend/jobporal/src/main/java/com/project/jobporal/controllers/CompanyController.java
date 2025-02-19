package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.CompanyDTO;
import com.project.jobporal.models.Companies;
import com.project.jobporal.services.CompanyService;
import lombok.*;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/v1/company")
@RequiredArgsConstructor
public class CompanyController {
    private final CompanyService companyService;

    @PostMapping("")
    public ResponseEntity<?> createCompany(@RequestBody CompanyDTO companyDTO, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errList = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errList);
        }
        companyService.crateCompany(companyDTO);
        return ResponseEntity.ok("create company successfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateCompany(@RequestBody CompanyDTO companyDTO,
                                           @PathVariable long id,
                                           BindingResult result
    ) {
        if (result.hasErrors()) {
            List<String> errList = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errList);
        }
        companyService.updateCompany(id, companyDTO);
        return ResponseEntity.ok("update company successfully with id = " + id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Companies> getCompanyById(@PathVariable Long id) {
        Companies companies = companyService.getCompanyById(id);
        return ResponseEntity.ok(companies);
    }

    @GetMapping("")
    public ResponseEntity<?> getAllCompany() {
        List<Companies> companies = companyService.getAllCompany();
        return ResponseEntity.ok(companies);
    }
}
