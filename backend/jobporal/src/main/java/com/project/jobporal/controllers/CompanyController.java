package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.CompanyDTO;
import com.project.jobporal.models.Companies;
import com.project.jobporal.services.CompanyService;
import lombok.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("api/v1/company")
@RequiredArgsConstructor
public class CompanyController {
    private final CompanyService companyService;
    @PostMapping("")
    public ResponseEntity<String> createCompany(@RequestBody CompanyDTO companyDTO){
        companyService.crateCompany(companyDTO);
        return ResponseEntity.ok("create company successfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateCompany(@RequestBody CompanyDTO companyDTO,
                                                @PathVariable long id
    ){
        companyService.updateCompany(id, companyDTO);
        return ResponseEntity.ok("update company successfully");
    }
    @GetMapping("/{id}")
    public ResponseEntity<Companies> getCompanyById(@PathVariable Long id){
        Companies companies = companyService.getCompanyById(id);
        return ResponseEntity.ok(companies);
    }

    @GetMapping("")
    public ResponseEntity<?> getAllCompany(){
        List<Companies> companies = companyService.getAllCompany();
        return ResponseEntity.ok(companies);
    }
}
