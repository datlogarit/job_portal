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
    private final RecruiterService recruiterService;

    @Override
    public void crateCompany(long recruiterId, CompanyDTO companyDTO, String fileName) {
        if (iCompanyRepository.existsByEmail(companyDTO.getEmail())) {
            throw new RuntimeException("Email đã tồn tại");
        }
        if (iCompanyRepository.existsByHotline(companyDTO.getHotline())) {
            throw new RuntimeException("Hotline đã được sử dụng");
        }
        if (iCompanyRepository.existsByName(companyDTO.getName())) {
            throw new RuntimeException("Công ty này đã tồn tại");
        }
        Companies newCompanies = Companies.builder()
                .name(companyDTO.getName())
                .taxCode(companyDTO.getTaxCode())
                .website(companyDTO.getWebsite())
                .scale(companyDTO.getScale())
                .email(companyDTO.getEmail())
                .location(companyDTO.getAddress())
                .introduction(companyDTO.getIntroduction())
                .url_avt(fileName)
                .hotline(companyDTO.getHotline())
                .build();
        iCompanyRepository.save(newCompanies);
//        update thong tin cty cho nhà tuyen dung
        recruiterService.updateCompany(recruiterId, newCompanies.getId());

    }

    @Override
    public Companies getCompanyById(long id) {
        return iCompanyRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Company not found"));
    }

    @Override
    public void updateCompany(long id, CompanyDTO companyDTO) {
        boolean isUpdate = false;
        Companies existCompany = getCompanyById(id);
        if (companyDTO.getName() != null) {
            existCompany.setName(companyDTO.getName());
            isUpdate = true;
        }
        if (companyDTO.getAddress() != null) {
            existCompany.setLocation(companyDTO.getAddress());
            isUpdate = true;
        }
        if (companyDTO.getIntroduction() != null) {
            existCompany.setIntroduction(companyDTO.getIntroduction());
            isUpdate = true;
        }
        if (companyDTO.getAvtUrl() != null) {
            existCompany.setUrl_avt(companyDTO.getAvtUrl());
            isUpdate = true;
        }
        if (companyDTO.getHotline() != null) {
            existCompany.setHotline(companyDTO.getHotline());
            isUpdate = true;
        }
        if (isUpdate) {
            iCompanyRepository.save(existCompany);
        }
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
