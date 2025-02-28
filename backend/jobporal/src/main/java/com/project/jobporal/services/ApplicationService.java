package com.project.jobporal.services;

import com.project.jobporal.DTOs.ApplicationDTO;
import com.project.jobporal.models.Applicants;
import com.project.jobporal.models.Applications;
import com.project.jobporal.models.Jobs;
import com.project.jobporal.repositories.IApplicationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ApplicationService implements IApplicationService {
    private final IApplicationRepository iApplicationRepository;
    private final ApplicantService applicantService;
    private final JobService jobService;

    @Override
    public void createApplication(ApplicationDTO applicationDTO) {
        Applicants applicants = applicantService.getApplicantById(applicationDTO.getApplicantId());
        Jobs jobs = jobService.getJobById(applicationDTO.getJobId());
        Applications newApplication = Applications.builder()
                .applicantId(applicants)
                .jobId(jobs)
                .statusApply("not yet")
                .isSaved(0)
                .isRead(0)
                .build();
        iApplicationRepository.save(newApplication);
    }

    @Override
    public void updateApplication(long id, ApplicationDTO applicationDTO) {
        Applications existApplication = getApplicationById(id);
//        Applicants applicants = applicantService.getApplicantById(applicationDTO.getApplicantId());
//        Jobs jobs = jobService.getJobById(applicationDTO.getJobId());
//        existApplication.setApplicantId(applicants);
//        existApplication.setJobId(jobs);
        existApplication.setStatusApply(applicationDTO.getStatusApply());
        existApplication.setIsSaved(applicationDTO.getIsSaved());
        existApplication.setIsRead(applicationDTO.getIsRead());
        iApplicationRepository.save(existApplication);
    }

    @Override
    public Applications getApplicationById(long id) {
        return iApplicationRepository.findById(id).orElseThrow(() -> new RuntimeException("application not found"));
    }

    @Override
    public Page<Applications> getAllApplication(PageRequest pageRequest) {
        return iApplicationRepository.findAll(pageRequest);
    }
}
