package com.project.jobportal.services;

import com.project.jobportal.DTOs.CompanyDTO;
import com.project.jobportal.models.Companies;

import java.util.List;

public interface ICompanyService {
    void updateCompany(long id, CompanyDTO companyDTO);

    void crateCompany(long recruiterId, CompanyDTO companyDTO, String fileName);

    Companies getCompanyById(long id);

    List<Companies> getAllCompany();

    Companies finByName(String companyName, String location, String fileName);
}
