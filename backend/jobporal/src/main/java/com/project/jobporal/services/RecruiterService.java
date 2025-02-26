package com.project.jobporal.services;

import java.util.List;

import com.project.jobporal.DTOs.User_RecruiterDTO;
import org.springframework.stereotype.Service;

import com.project.jobporal.models.Companies;
import com.project.jobporal.models.Recruiters;
import com.project.jobporal.models.Users;
import com.project.jobporal.repositories.IRecruiterRepository;
import com.project.jobporal.repositories.IUserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RecruiterService implements IRecruiterService {
    private final IRecruiterRepository iRecruiterRepository;
    private final IUserRepository iUserRepository;
    private final CompanyService CompanyService;

    @Override
    public void createRecruiter(User_RecruiterDTO userRecruiter) {
        Users newUser = Users.builder()
                .email(userRecruiter.getEmail())
                .password(userRecruiter.getPassword())
                .name(userRecruiter.getName())
                .phoneNumber(userRecruiter.getPhoneNumber())
                .dob(userRecruiter.getDob())
                .role("recruiter")
                .urlAvatar(userRecruiter.getUrlAvatar())
                .isActive(userRecruiter.getIsActive())
                .build();

        Companies existCompany =
                CompanyService.getCompanyById(userRecruiter.getCompanyId());
        Recruiters recruiters = Recruiters.builder()
                .userId(newUser)
                .company_id(existCompany)
                .isVerify(userRecruiter.getIsVerify())
                .numberOfPost(userRecruiter.getNumberOfPost())
                .position(userRecruiter.getPosition())
                .build();
        iRecruiterRepository.save(recruiters);
    }

    @Override
    public void updateRecruiter(long id, User_RecruiterDTO userRecruiterDTO) {
        Users existUser = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));
        existUser.setPassword(userRecruiterDTO.getPassword());
        existUser.setName(userRecruiterDTO.getName());
        existUser.setPhoneNumber(userRecruiterDTO.getPhoneNumber());
        existUser.setDob(userRecruiterDTO.getDob());
        existUser.setUrlAvatar(userRecruiterDTO.getUrlAvatar());
        Companies existCompany =
                CompanyService.getCompanyById(userRecruiterDTO.getCompanyId());
        Recruiters existRecruiters = getRecruiter(id);
        existRecruiters.setUserId(existUser);
        existRecruiters.setCompany_id(existCompany);
        existRecruiters.setIsVerify(userRecruiterDTO.getIsVerify());
        existRecruiters.setNumberOfPost(userRecruiterDTO.getNumberOfPost());
        existRecruiters.setPosition(userRecruiterDTO.getPosition());
        iRecruiterRepository.save(existRecruiters);
    }

    @Override
    public void deleteRecruiter() {
        // TODO Auto-generated method stub
    }

    @Override
    public Recruiters getRecruiter(long id) {
        Recruiters recruiters = iRecruiterRepository.findById(id).orElseThrow(() -> new
                RuntimeException("Recruiter not found"));
        // TODO Auto-generated method stub
        return recruiters;
    }

    @Override
    public Page<Recruiters> getAllRecruiters(PageRequest pageRequest) {
        return iRecruiterRepository.findAll(pageRequest);
    }

}
