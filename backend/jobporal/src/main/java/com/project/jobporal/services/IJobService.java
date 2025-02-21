package com.project.jobporal.services;

import com.project.jobporal.DTOs.JobDTO;
import com.project.jobporal.models.Jobs;

import java.util.List;
import java.util.Optional;

public interface IJobService {
    void createJob(JobDTO jobDTO);

    void updateJob(long id, JobDTO jobDTO);

    Jobs getJobById(long id);

    List<Jobs> getAllJob();

    List<Jobs> searchJob(String search_title);

    List<Jobs> searchJobByCategory(Long categoryId);

    List<Jobs> searchJobByCompany(long companyId);

    List<Jobs> searchJobByFilter(String catgoryName, String positon, String experience, Integer minSalary,
            Integer maxSalary);
}
