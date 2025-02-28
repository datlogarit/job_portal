package com.project.jobporal.services;

import com.project.jobporal.DTOs.ApplicationDTO;
import com.project.jobporal.models.Applications;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface IApplicationService {
    void createApplication(ApplicationDTO applicationDTO);

    void updateApplication(long id, ApplicationDTO applicationDTO);

    Applications getApplicationById(long id);

    Page<Applications> getAllApplication(PageRequest pageRequest);
}
