package com.project.jobportal.services;

import com.project.jobportal.DTOs.CompanyDTO;
import com.project.jobportal.models.Companies;

import java.util.List;

public interface ICompanyService {
    void crateCompany(CompanyDTO companyDTO, String file);

    void updateCompany(long id, CompanyDTO companyDTO);

    Companies getCompanyById(long id);

    List<Companies> getAllCompany();

    Companies finByName(String companyName, String location, String fileName);
}
