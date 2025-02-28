package com.project.jobporal.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.jobporal.DTOs.RecruiterVerificationDTO;
import com.project.jobporal.models.RecruiterVerifications;
import com.project.jobporal.models.Recruiters;
import com.project.jobporal.repositories.IRecruiterRepository;
import com.project.jobporal.repositories.IRecruiterVerificationRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RecruiterVerificationService implements
        IRecruiterVerificationsService {
    private final IRecruiterVerificationRepository recruiterVerificationRepository;
    //    private final IRecruiterRepository recruiterRepository;
    private final RecruiterService recruiterService;

    @Override
    public void createRecruiterVerification(RecruiterVerificationDTO recruiterVerificationDTO) {
        Recruiters existRecruiter = recruiterService.getRecruiter(recruiterVerificationDTO.getRecruiterId());
        RecruiterVerifications recruiterVerifications = RecruiterVerifications.builder()
                .recruiterId(existRecruiter)
                .authorizationLetterUrl(recruiterVerificationDTO.getAuthorizationLetterUrl())
                .businessLicenseUrl(recruiterVerificationDTO.getBusinessLicenseUrl())
                .status(0)
                .rejectReason("")
                .build();
        recruiterVerificationRepository.save(recruiterVerifications);
    }

    @Override
    public void updateRecruiterVerification(long id, RecruiterVerificationDTO recruiterVerificationDTO) {
        // tìm xem bản ghi này có tồn tại không
        RecruiterVerifications existRecruiterVerification = getRecruiterVerificationById(id);
        if (existRecruiterVerification == null) {
            throw new RuntimeException("Recruiter Verification not found");
        }
        existRecruiterVerification.setAuthorizationLetterUrl(recruiterVerificationDTO.getAuthorizationLetterUrl());
        existRecruiterVerification.setBusinessLicenseUrl(recruiterVerificationDTO.getBusinessLicenseUrl());
        existRecruiterVerification.setStatus(recruiterVerificationDTO.getStatus());
        existRecruiterVerification.setStatus(recruiterVerificationDTO.getStatus());
        existRecruiterVerification.setRejectReason(recruiterVerificationDTO.getRejectReason());
        recruiterVerificationRepository.save(existRecruiterVerification);
    }

    @Override
    public RecruiterVerifications getRecruiterVerificationById(long id) {
        RecruiterVerifications existRecruiterVerification = recruiterVerificationRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Recruiter Verification not found"));
        return existRecruiterVerification;
    }

    @Override
    public List<RecruiterVerifications> getAllRecruiterVerification() {
        return recruiterVerificationRepository.findAll();
    }

}
