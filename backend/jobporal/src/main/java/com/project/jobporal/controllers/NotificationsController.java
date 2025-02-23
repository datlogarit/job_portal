package com.project.jobporal.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("api/v1/notification")
@RestController
public class NotificationsController {
    @PostMapping("")
    public ResponseEntity<?> createNotification() {
        return null;
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateNotification() {
        return null;
    }
}
