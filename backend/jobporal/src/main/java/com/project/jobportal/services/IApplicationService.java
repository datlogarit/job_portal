package com.project.jobportal.services;

import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.DTOs.InteractionDTO;
import com.project.jobportal.models.Applications;
import com.project.jobportal.models.Interactions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface IApplicationService {
//    void createApplication(ApplicationDTO applicationDTO);

    void createApplication(ApplicationDTO applicationDTO, String fileName);

    Applications getApplicationByApplicantIdAndJobId(long applicantId, long jobId);

    List<Applications> getAllApplicationByApplicantId(long id);
}
