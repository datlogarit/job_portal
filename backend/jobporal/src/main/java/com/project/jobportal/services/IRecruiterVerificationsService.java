package com.project.jobportal.services;

import java.util.List;

import com.project.jobportal.DTOs.RecruiterVerificationDTO;
import com.project.jobportal.models.RecruiterVerifications;

public interface IRecruiterVerificationsService {
    void createRecruiterVerification(RecruiterVerificationDTO recruiterVerificationDTO,
                                     String businessLicense,
                                     String authorizationLetter);

    void updateRecruiterVerification(long id, RecruiterVerificationDTO recruiterVerificationDTO);

    RecruiterVerifications getRecruiterVerificationById(long id);

    List<RecruiterVerifications> getAllRecruiterVerification();
}
