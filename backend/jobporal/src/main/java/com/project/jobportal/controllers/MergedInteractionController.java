package com.project.jobportal.controllers;

import com.project.jobportal.services.MergedInteractionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RequestMapping("api/v1/mergedInteraction")
@RestController
public class MergedInteractionController {
    private final MergedInteractionService mergedInteractionService;

    @GetMapping("/{applicantId}")
    private ResponseEntity<?> getAllMergedInteraction(@PathVariable long applicantId) {
        return ResponseEntity.ok(mergedInteractionService.getAllMergedInteraction(applicantId));
    }
}
