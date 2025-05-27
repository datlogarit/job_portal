package com.project.jobportal.services;

import com.project.jobportal.DTOs.JobDTO;
import com.project.jobportal.DTOs.RecommenInputDTO;
import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Jobs;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;

import java.time.LocalDate;
import java.util.List;

public interface IJobService {
    void createJob(JobDTO jobDTO);

    void createVirtualData(String title, String experience, String workingTime, int numberRecruitment, String gender,
                           String position, LocalDate exp_date, String requirement, String description,
                           String benefit, String workLocation, String category,
                           int minSalary, int maxSalary, String companyName, String ImgCpnUrl,
                           String introduction, String location, String email, String name, String password);

    void updateJob(long id, JobDTO jobDTO);

    Jobs getJobById(long id);

    Page<Jobs> getJobByRecruiterId(long recruiterId, PageRequest pageRequest);

    Page<Jobs> getAllJob(PageRequest pageRequest);

    Page<Jobs> searchJob(String search_title, PageRequest pageRequest);

    Page<Jobs> searchJobByCategory(Long categoryId, PageRequest pageRequest);

    Page<Jobs> searchJobByCompany(long companyId, PageRequest pageRequest);

    Page<Jobs> searchJobByFilter(String catgoryName, String positon, String experience, Integer minSalary,
                                 Integer maxSalary, PageRequest pageRequest);

    List<Jobs> searchSameJobById(long jobId) throws Exception;

//    List<Applicants> searchSameApplicantByJobId(long jobId) throws Exception;

    List<Jobs> getRecommendedJob(RecommenInputDTO recommenInputDTO) throws Exception;
}
