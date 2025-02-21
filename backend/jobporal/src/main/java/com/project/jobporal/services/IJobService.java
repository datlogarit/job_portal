package com.project.jobporal.services;

import com.project.jobporal.DTOs.JobDTO;
import com.project.jobporal.models.Jobs;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface IJobService {
    void createJob(JobDTO jobDTO);

    void updateJob(long id, JobDTO jobDTO);

    Jobs getJobById(long id);

    Page<Jobs> getAllJob(PageRequest pageRequest);

    Page<Jobs> searchJob(String search_title, PageRequest pageRequest);

    Page<Jobs> searchJobByCategory(Long categoryId, PageRequest pageRequest);

    Page<Jobs> searchJobByCompany(long companyId, PageRequest pageRequest);

    Page<Jobs> searchJobByFilter(String catgoryName, String positon, String experience, Integer minSalary,
            Integer maxSalary, PageRequest pageRequest);
}
