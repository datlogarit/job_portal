package com.project.jobporal.services;

import com.project.jobporal.DTOs.CompanyDTO;
import com.project.jobporal.models.Companies;
import com.project.jobporal.repositories.ICompanyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@RequiredArgsConstructor
public class CompanyService implements ICompanyService{
    private final ICompanyRepository iCompanyRepository;
    @Override
    public void crateCompany(CompanyDTO companyDTO) {
        Companies newCompanies = Companies.builder()
                .name(companyDTO.getName())
                .location(companyDTO.getLocation())
                .introduction(companyDTO.getIntroduction())
                .url_avt(companyDTO.getAvtUrl())
                .hotline(companyDTO.getHotline())
                .build();
        iCompanyRepository.save(newCompanies);
    }

    @Override
    public Companies getCompanyById(long id) {
        return iCompanyRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found"));
    }

    @Override
    public void updateCompany(long id, CompanyDTO companyDTO) {
        Companies existCompany = getCompanyById(id);
        existCompany.setName(companyDTO.getName());
        existCompany.setLocation(existCompany.getLocation());
        existCompany.setIntroduction(existCompany.getIntroduction());
        existCompany.setUrl_avt(existCompany.getUrl_avt());
        existCompany.setHotline(existCompany.getHotline());
        iCompanyRepository.save(existCompany);
    }



    @Override
    public List<Companies> getAllCompany() {
        return iCompanyRepository.findAll();
    }
}
