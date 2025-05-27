package com.project.jobportal.services;

import com.project.jobportal.DTOs.InteractionDTO;
import com.project.jobportal.models.Interactions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface IInteractionService {
    Interactions createInteraction(InteractionDTO interactionDTO);

    void updateReadInteraction(InteractionDTO interactionDTO);

    void updateSaveInteraction(long applicantId, long jobId, InteractionDTO interactionDTO);

    Interactions getInteractionById(long id);

    List<Interactions> getAllInteractionByUserId(long userId);

    Interactions findByApplicantIdAndJobId(long applicantId, long jobId);
}
