package com.project.jobporal.services;

import java.util.List;

import com.project.jobporal.DTOs.RecruiterVerificationDTO;
import com.project.jobporal.models.RecruiterVerifications;

public interface IRecruiterVerificationsService {
    void createRecruiterVerification(RecruiterVerificationDTO recruiterVerificationDTO,
                                     String businessLicense,
                                     String authorizationLetter);

    void updateRecruiterVerification(long id, RecruiterVerificationDTO recruiterVerificationDTO);

    RecruiterVerifications getRecruiterVerificationById(long id);

    List<RecruiterVerifications> getAllRecruiterVerification();
}
