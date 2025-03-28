package com.project.jobportal.services;

import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Applications;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.repositories.IApplicationRepository;
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
                .isSaved(applicationDTO.getIsSaved())
                .isRead(applicationDTO.getIsRead())
                .build();
        iApplicationRepository.save(newApplication);
    }

    @Override
    public void updateApplication(long applicantId, long jobId, ApplicationDTO applicationDTO) {
        boolean isUpdate = false;
        Applications existApplication = findByApplicantIdAndJobId(applicantId, jobId);
        if (applicationDTO.getStatusApply() != null) {
            existApplication.setStatusApply(applicationDTO.getStatusApply());
            isUpdate = true;
        }
        if (applicationDTO.getIsSaved() != 0) {
            existApplication.setIsSaved(applicationDTO.getIsSaved());
            isUpdate = true;
        }
        if (applicationDTO.getIsRead() != 0) {
            existApplication.setIsRead(applicationDTO.getIsRead());
            isUpdate = true;
        }
        if (isUpdate) {
            iApplicationRepository.save(existApplication);
        }
    }

    @Override
    public void updateSaveApplication(long applicantId, long jobId, ApplicationDTO applicationDTO) {
        Applications existApplication = findByApplicantIdAndJobId(applicantId, jobId);


        existApplication.setIsSaved(applicationDTO.getIsSaved());


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

    @Override
    public Applications findByApplicantIdAndJobId(long applicantId, long jobId) {

        Applications applications = iApplicationRepository.finByApplicantIdAndJobId(applicantId, jobId).orElseThrow(()
                -> new RuntimeException("Application not found"));
        ;
        return applications;
    }
}
