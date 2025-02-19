package com.project.jobporal.services;

import java.util.List;

import com.project.jobporal.DTOs.JobDTO;
import com.project.jobporal.models.Categories;
import com.project.jobporal.models.Companies;
import com.project.jobporal.models.Jobs;
import com.project.jobporal.models.Recruiters;
import com.project.jobporal.repositories.IJobReposiroty;
import com.project.jobporal.repositories.IRecruiterRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class JobService implements IJobService {
    private final IJobReposiroty iJobReposiroty;
    private final IRecruiterRepository iRecruiterRepository;
    private final ICompanyService iCompanyService;
    private final ICategoryService iCategoryService;

    @Override
    public void createJob(JobDTO jobDTO) {
        Recruiters existRecruiter = iRecruiterRepository.findById(jobDTO.getPostedBy()).get();
        if (existRecruiter == null) {
            throw new RuntimeException("Recruiter not found");
        }

        Companies existCompany = iCompanyService.getCompanyById(jobDTO.getCompanyId());
        if (existCompany == null) {
            throw new RuntimeException("Company not found");
        }

        Categories existCategory = iCategoryService.getCategoryById(jobDTO.getCategoryId());
        if (existCategory == null) {
            throw new RuntimeException("Category not found");
        }

        Jobs jobs = Jobs.builder()
                .title(jobDTO.getTitle())
                .salaryRange(jobDTO.getSalaryRange())
                .experience(jobDTO.getExperience())
                .workingTime(jobDTO.getWorkingTime())
                .numberRecruitment(jobDTO.getNumberRecruitment())
                .gender(jobDTO.getGender())
                .position(jobDTO.getPosition())
                .expDate(jobDTO.getExpDate())
                .requirement(jobDTO.getRequirement())
                .description(jobDTO.getDescription())
                .benefit(jobDTO.getBenefit())
                .workLocation(jobDTO.getWorkLocation())
                .postedBy(existRecruiter)
                .companyId(existCompany)
                .categoryId(existCategory)
                .status(jobDTO.getStatus())
                .isEdit(jobDTO.getIsEdit())
                .isLock(jobDTO.getIsLock())
                .isActive(jobDTO.getIsActive())
                .build();
        iJobReposiroty.save(jobs);
    }

    @Override
    public void updateJob(long id, JobDTO jobDTO) {
        Jobs existJob = iJobReposiroty.findById(id).orElseThrow(() -> new RuntimeException("Job not found"));
        existJob.setTitle(jobDTO.getTitle());
        existJob.setSalaryRange(jobDTO.getSalaryRange());
        existJob.setExperience(jobDTO.getExperience());
        existJob.setWorkingTime(jobDTO.getWorkingTime());
        existJob.setNumberRecruitment(jobDTO.getNumberRecruitment());
        existJob.setGender(jobDTO.getGender());
        existJob.setPosition(jobDTO.getPosition());
        existJob.setExpDate(jobDTO.getExpDate());
        existJob.setRequirement(jobDTO.getRequirement());
        existJob.setDescription(jobDTO.getDescription());
        existJob.setBenefit(jobDTO.getBenefit());
        existJob.setWorkLocation(jobDTO.getWorkLocation());
        existJob.setPostedBy(iRecruiterRepository.findById(jobDTO.getPostedBy()).get());
        existJob.setCompanyId(iCompanyService.getCompanyById(jobDTO.getCompanyId()));
        existJob.setCategoryId(iCategoryService.getCategoryById(jobDTO.getCategoryId()));
        existJob.setStatus(jobDTO.getStatus());
        existJob.setIsEdit(jobDTO.getIsEdit());
        existJob.setIsLock(jobDTO.getIsLock());
        existJob.setIsActive(jobDTO.getIsActive());
        iJobReposiroty.save(existJob);
    }

    @Override
    public Jobs getJobById(long id) {
        return iJobReposiroty.findById(id).orElseThrow(() -> new RuntimeException("Job not found"));
    }

    @Override
    public List<Jobs> getAllJob() {
        return iJobReposiroty.findAll();
    }

    @Override
    public List<Jobs> searchJob(String title) {
        return iJobReposiroty.searchJob(title);
    }
}
