package com.project.jobportal.services;

import com.project.jobportal.DTOs.User_RecruiterDTO;
import com.project.jobportal.models.RecruiterVerifications;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import com.project.jobportal.models.Recruiters;

public interface IRecruiterService {
    Recruiters login(String email, String password);

    void createRecruiter(User_RecruiterDTO userRecruiterDTO);

    void updateRecruiter(long Id, User_RecruiterDTO userRecruiterDTO);

//    void updateCompany(long companyId);

    void updateCompany(long recruiterId, long companyId);

    void updateVerification(long recruiterId, long verificationId);

    void deleteRecruiter();

    Recruiters getRecruiter(long id);

    Page<Recruiters> getAllRecruiters(PageRequest pageRequest);
}
