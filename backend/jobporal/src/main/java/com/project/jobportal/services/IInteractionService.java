package com.project.jobportal.services;

import com.project.jobportal.DTOs.InteractionDTO;
import com.project.jobportal.models.Interactions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface IInteractionService {
    void createInteraction(InteractionDTO interactionDTO);

    void updateInteraction(long applicantId, long jobId, InteractionDTO interactionDTO);

    void updateSaveInteraction(long applicantId, long jobId, InteractionDTO interactionDTO);

    Interactions getInteractionById(long id);

    Page<Interactions> getAllInteraction(PageRequest pageRequest);

    Interactions findByApplicantIdAndJobId(long applicantId, long jobId);
}
