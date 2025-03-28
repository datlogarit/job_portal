package com.project.jobportal.services;

import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.models.Applications;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.Optional;

public interface IApplicationService {
    void createApplication(ApplicationDTO applicationDTO);

    void updateApplication(long applicantId, long jobId, ApplicationDTO applicationDTO);

    void updateSaveApplication(long applicantId, long jobId, ApplicationDTO applicationDTO);

    Applications getApplicationById(long id);

    Page<Applications> getAllApplication(PageRequest pageRequest);

    Applications findByApplicantIdAndJobId(long applicantId, long jobId);
}
