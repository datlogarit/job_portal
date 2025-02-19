package com.project.jobporal.services;

import com.project.jobporal.DTOs.JobDTO;
import com.project.jobporal.models.Jobs;

import java.util.List;

public interface IJobService {
    void createJob(JobDTO jobDTO);

    void updateJob(long id, JobDTO jobDTO);

    Jobs getJobById(long id);

    List<Jobs> getAllJob();

    List<Jobs> searchJob(String title);
}
