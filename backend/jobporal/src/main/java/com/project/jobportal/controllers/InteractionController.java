package com.project.jobportal.controllers;

import com.project.jobportal.DTOs.InteractionDTO;
import com.project.jobportal.services.InteractionService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/interaction")
@RequiredArgsConstructor
public class InteractionController {
    private final InteractionService interactionService;

    @PostMapping("")
    public ResponseEntity<?> createInteraction(@RequestBody InteractionDTO interactionDTO) {
        interactionService.createInteraction(interactionDTO);
        return ResponseEntity.ok("create Interaction successfully");
    }

    @PutMapping("/read")
    public ResponseEntity<?> updateInteraction(
            @RequestBody InteractionDTO interactionDTO) {
        interactionService.updateReadInteraction(interactionDTO);
        return ResponseEntity.ok(String.format("update interaction successfully with applicantId = %d and jobId = %d",
                interactionDTO.getApplicantId(),
                interactionDTO.getJobId()));
    }

    @PutMapping("/save/{applicantId}/{jobId}")
    public ResponseEntity<?> updateSaveInteraction(@PathVariable long applicantId, @PathVariable long jobId,
                                                   @RequestBody InteractionDTO interactionDTO) {
        interactionService.updateSaveInteraction(applicantId, jobId, interactionDTO);
        return ResponseEntity.ok(String.format("update save interaction successfully with applicantId = %d and jobId = %d", applicantId, jobId));
    }

    @GetMapping("/{applicantId}/{jobId}")
    public ResponseEntity<?> getInteractionById(@PathVariable(name = "applicantId") long applicantId,
                                                @PathVariable(name = "jobId") long jobId) {
        return ResponseEntity.ok(interactionService.findByApplicantIdAndJobId(applicantId, jobId));
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getAllInteractionByUserId(@PathVariable("userId") Long userId) {
        return ResponseEntity.ok(interactionService.getAllInteractionByUserId(userId));
    }
}
