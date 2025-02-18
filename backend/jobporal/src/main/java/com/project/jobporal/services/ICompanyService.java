package com.project.jobporal.services;

import com.project.jobporal.DTOs.CompanyDTO;
import com.project.jobporal.models.Companies;

import java.util.List;

public interface ICompanyService {
    void crateCompany(CompanyDTO companyDTO);
    void updateCompany(long id, CompanyDTO companyDTO);
    Companies getCompanyById(long id);
    List<Companies> getAllCompany();
}
