package com.project.jobportal.services;

import com.project.jobportal.DTOs.User_ApplicantDTO;
import com.project.jobportal.models.Applicants;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface IApplicantService {
    void crateApplicant(User_ApplicantDTO applicantDTO);

    void updateApplicant(long id, User_ApplicantDTO applicantDTO);

    Applicants getApplicantById(long id);

    Page<Applicants> getAllApplicant(PageRequest pageRequest);
}
