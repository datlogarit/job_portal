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
    private final InteractionService applicationService;

    @PostMapping("")
    public ResponseEntity<?> createInteraction(@RequestBody InteractionDTO interactionDTO) {
        applicationService.createInteraction(interactionDTO);
        return ResponseEntity.ok("create Interaction successfully");
    }

    @PutMapping("/{applicantId}/{jobId}")
    public ResponseEntity<?> updateInteraction(@PathVariable long applicantId, @PathVariable long jobId,
                                               @RequestBody InteractionDTO interactionDTO) {
        applicationService.updateInteraction(applicantId, jobId, interactionDTO);
        return ResponseEntity.ok(String.format("update interaction successfully with applicantId = %d and jobId = %d", applicantId, jobId));
    }

    @PutMapping("/save/{applicantId}/{jobId}")
    public ResponseEntity<?> updateSaveInteraction(@PathVariable long applicantId, @PathVariable long jobId,
                                                   @RequestBody InteractionDTO interactionDTO) {
        applicationService.updateSaveInteraction(applicantId, jobId, interactionDTO);
        return ResponseEntity.ok(String.format("update save interaction successfully with applicantId = %d and jobId = %d", applicantId, jobId));
    }

    @GetMapping("/info")
    public ResponseEntity<?> getInteractionById(@RequestParam("applicantId") long applicantId,
                                                @RequestParam("jobId") long jobId) {
        return ResponseEntity.ok(applicationService.findByApplicantIdAndJobId(applicantId, jobId));
    }

    @GetMapping("")
    public ResponseEntity<?> getAllInteraction(@RequestParam("page") int page,
                                               @RequestParam("limit") int limit) {
        PageRequest pageRequest1 = PageRequest.of(page, limit, Sort.by("createdAt").descending());
        return ResponseEntity.ok(applicationService.getAllInteraction(pageRequest1).getContent());
    }

    @GetMapping("/{userId}")
    public ResponseEntity<?> getAllInteractionByUserId(@RequestParam("page") int page,
                                                       @RequestParam("limit") int limit) {
        PageRequest pageRequest1 = PageRequest.of(page, limit, Sort.by("createdAt").descending());
        return ResponseEntity.ok(applicationService.getAllInteraction(pageRequest1).getContent());
    }
}
