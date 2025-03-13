package com.project.jobportal.services;

import com.project.jobportal.DTOs.CompanyDTO;
import com.project.jobportal.models.Companies;
import com.project.jobportal.repositories.ICompanyRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CompanyService implements ICompanyService {
    private final ICompanyRepository iCompanyRepository;

    @Override
    public void crateCompany(CompanyDTO companyDTO, String fileName) {
        Companies newCompanies = Companies.builder()
                .name(companyDTO.getName())
                .location(companyDTO.getLocation())
                .introduction(companyDTO.getIntroduction())
                .url_avt(fileName)
                .hotline(companyDTO.getHotline())
                .build();
        iCompanyRepository.save(newCompanies);
    }

    @Override
    public Companies getCompanyById(long id) {
        return iCompanyRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Company not found"));
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


    public Companies crateCompanyForFake(String name, String location, String fileName) {
        Companies newCompanies = Companies.builder()
                .name(name)
                .location(location)
                .introduction("day la cong ty de test")
                .url_avt(fileName)
                .build();
        iCompanyRepository.save(newCompanies);
        return newCompanies;
    }

    @Override
    public Companies finByName(String companyName, String location, String fileName) {
        return iCompanyRepository.findByName(companyName).orElseGet(() -> crateCompanyForFake(companyName, location, fileName));
    }
}
