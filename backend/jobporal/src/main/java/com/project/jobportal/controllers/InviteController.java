package com.project.jobportal.controllers;

import com.project.jobportal.DTOs.InviteDTO;
import com.project.jobportal.services.InviteService;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("api/v1/invite")
public class InviteController {
    private final InviteService inviteService;

    @PostMapping("")
    public ResponseEntity<?> createInvite(@RequestBody InviteDTO inviteDTO) {
        inviteService.createInvite(inviteDTO);
        return ResponseEntity.ok("create invite successfully");
    }
}
