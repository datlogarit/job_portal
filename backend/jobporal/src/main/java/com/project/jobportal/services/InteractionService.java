package com.project.jobportal.services;

import com.project.jobportal.DTOs.InteractionDTO;
import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Interactions;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.repositories.IInteractionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class InteractionService implements IInteractionService {
    private final IInteractionRepository iInteractionRepository;
    private final ApplicantService applicantService;
    private final JobService jobService;

    @Override
    public Interactions createInteraction(InteractionDTO interactionDTO) {
        Applicants applicants = applicantService.getApplicantById(interactionDTO.getApplicantId());
        Jobs jobs = jobService.getJobById(interactionDTO.getJobId());
        Interactions newInteraction = Interactions.builder()
                .applicantId(applicants)
                .jobId(jobs)
                .isSaved(interactionDTO.getIsSaved())
                .isRead(interactionDTO.getIsRead())
                .build();
        iInteractionRepository.save(newInteraction);
        return newInteraction;
    }

    @Override
    public void updateReadInteraction(InteractionDTO interactionDTO) {
        Interactions existInteraction = iInteractionRepository.findByApplicantIdAndJobId(
                interactionDTO.getApplicantId(), interactionDTO.getJobId()).orElseGet(() ->
                createInteraction(interactionDTO
                )
        );
//        if (existInteraction.getIsRead() != 1) {
        existInteraction.setIsRead(1L);
        iInteractionRepository.save(existInteraction);
//        }
    }

    @Override
    public void updateSaveInteraction(long applicantId, long jobId, InteractionDTO interactionDTO) {
        Interactions existInteraction = findByApplicantIdAndJobId(applicantId, jobId);
        existInteraction.setIsSaved(interactionDTO.getIsSaved());
        iInteractionRepository.save(existInteraction);
    }


    @Override
    public Interactions getInteractionById(long id) {
        return iInteractionRepository.findById(id).orElseThrow(() -> new RuntimeException("application not found"));
    }

    @Override
    public List<Interactions> getAllInteractionByUserId(long userId) {
        return iInteractionRepository.finByApplicantId(userId).orElseThrow(()
                -> new RuntimeException("Interaction not found"));
    }

    @Override
    public Interactions findByApplicantIdAndJobId(long applicantId, long jobId) {
        Interactions interactions = iInteractionRepository.findByApplicantIdAndJobId(applicantId, jobId).orElseThrow(()
                -> new RuntimeException("Interaction not found"));
        return interactions;
    }
}
