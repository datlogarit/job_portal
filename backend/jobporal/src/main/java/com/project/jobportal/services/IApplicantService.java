package com.project.jobportal.services;

import com.project.jobportal.DTOs.User_ApplicantDTO;
import com.project.jobportal.models.Applicants;

import com.project.jobportal.response.LoginResponse;
import com.project.jobportal.response.RecommendApplicantResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface IApplicantService {
//    LoginResponse login(String email, String password);

    void crateApplicant(User_ApplicantDTO applicantDTO);

    Applicants updateApplicant(long id, User_ApplicantDTO applicantDTO);

    Applicants getApplicantById(long id);

    List<RecommendApplicantResponse> recommendApplicantByJobId(long jobId) throws Exception;

    Page<Applicants> getAllApplicant(PageRequest pageRequest);

    long countTotalApplicant();
}
