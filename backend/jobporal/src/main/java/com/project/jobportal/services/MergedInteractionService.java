package com.project.jobportal.services;

import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.MergedInteraction;
import com.project.jobportal.repositories.IMergedInteractionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MergedInteractionService {
    private final IMergedInteractionRepository iMergedInteractionRepository;
    private final ApplicantService applicantService;

    public List<MergedInteraction> getAllMergedInteraction(long applicantId) {
        Applicants applicants = applicantService.getApplicantById(applicantId);
        return iMergedInteractionRepository.findByApplicantId(applicants, Sort.by(
                Sort.Direction.DESC, "updatedAt"));
    }
}
