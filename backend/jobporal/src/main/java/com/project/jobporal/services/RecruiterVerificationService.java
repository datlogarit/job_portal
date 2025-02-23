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
    private final IRecruiterRepository recruiterRepository;

    @Override
    public void createRecruiterVerification(RecruiterVerificationDTO recruiterVerificationDTO) {
        // TODO Auto-generated method stub
        Recruiters existRecruiter = recruiterRepository.findById(recruiterVerificationDTO.getRecruiterId())
                .orElseThrow(() -> new RuntimeException("recruiter not found"));
        RecruiterVerifications recruiterVerifications = RecruiterVerifications.builder()
                .recruiterId(existRecruiter)
                .authorizationLetterUrl(recruiterVerificationDTO.getAuthorizationLetterUrl())
                .businessLicenseUrl(recruiterVerificationDTO.getBusinessLicenseUrl())
                .status(recruiterVerificationDTO.getStatus())
                .rejectReason(recruiterVerificationDTO.getRejectReason())
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
        // tìm nhà tuyển dụng theo id mới
        Recruiters newRecruiter = recruiterRepository.findById(recruiterVerificationDTO.getRecruiterId())
                .orElseThrow(() -> new RuntimeException("recruiter not found"));
        existRecruiterVerification.setRecruiterId(newRecruiter);
        existRecruiterVerification.setAuthorizationLetterUrl(recruiterVerificationDTO.getAuthorizationLetterUrl());
        existRecruiterVerification.setBusinessLicenseUrl(recruiterVerificationDTO.getBusinessLicenseUrl());
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
