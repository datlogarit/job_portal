package com.project.jobportal.services;

import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.models.Applications;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface IApplicationService {
    void createApplication(ApplicationDTO applicationDTO);

    void updateApplication(long id, ApplicationDTO applicationDTO);

    Applications getApplicationById(long id);

    Page<Applications> getAllApplication(PageRequest pageRequest);
}
