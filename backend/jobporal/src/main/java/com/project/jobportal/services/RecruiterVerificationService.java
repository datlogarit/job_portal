package com.project.jobportal.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.jobportal.models.RecruiterVerifications;
import com.project.jobportal.repositories.IRecruiterVerificationRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RecruiterVerificationService implements
        IRecruiterVerificationsService {
    private final IRecruiterVerificationRepository recruiterVerificationRepository;
    private final RecruiterService recruiterService;

    @Override
    public void createRecruiterVerification(
            long recruiterId,
            String businessLicense,
            String authorizationLetter) {
        RecruiterVerifications recruiterVerifications = RecruiterVerifications.builder()
                .businessLicenseUrl(businessLicense)
                .authorizationLetterUrl(authorizationLetter)
                .status(1)
                .rejectReason("")
                .build();
        recruiterVerificationRepository.save(recruiterVerifications);
        recruiterService.updateVerification(recruiterId, recruiterVerifications.getId());
    }

    @Override
    public void updateRecruiterVerification(
            long verifyId,
            String businessLicense,
            String authorizationLetter) {
        RecruiterVerifications recruiterVerifications = recruiterVerificationRepository.findById(verifyId).orElseThrow(
                () -> new RuntimeException("Recruiter verify not found"));
        recruiterVerifications
                .setBusinessLicenseUrl(businessLicense);
        recruiterVerifications.setAuthorizationLetterUrl(authorizationLetter);
        recruiterVerifications.setStatus(1);
        recruiterVerificationRepository.save(recruiterVerifications);
//        recruiterService.updateVerification(recruiterId, recruiterVerifications.getId());
    }

    //    @Override
//    public void updateRecruiterVerification(long id, RecruiterVerificationDTO recruiterVerificationDTO) {
//        // tìm xem bản ghi này có tồn tại không
//        RecruiterVerifications existRecruiterVerification = getRecruiterVerificationById(id);
//        if (existRecruiterVerification == null) {
//            throw new RuntimeException("Recruiter Verification not found");
//        }
//        existRecruiterVerification.setAuthorizationLetterUrl(recruiterVerificationDTO.getAuthorizationLetterUrl());
//        existRecruiterVerification.setBusinessLicenseUrl(recruiterVerificationDTO.getBusinessLicenseUrl());
//        existRecruiterVerification.setStatus(recruiterVerificationDTO.getStatus());
//        existRecruiterVerification.setStatus(recruiterVerificationDTO.getStatus());
//        existRecruiterVerification.setRejectReason(recruiterVerificationDTO.getRejectReason());
//        recruiterVerificationRepository.save(existRecruiterVerification);
//    }
    public void updateStatusVerify(Long verifyId, int status) {
        RecruiterVerifications recruiterVerifications = recruiterVerificationRepository.findById(verifyId).orElseThrow(
                () -> new RuntimeException("verifycation not found"));
        recruiterVerifications.setStatus(status);
        recruiterVerificationRepository.save(recruiterVerifications);
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

    @Override
    public long countTotalAuthenticationPending() {
        return recruiterVerificationRepository.countByStatus(1);
    }
}
