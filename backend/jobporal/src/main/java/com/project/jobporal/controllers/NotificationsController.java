package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.NotificationDTO;
import com.project.jobporal.services.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("api/v1/notification")
@RestController
@RequiredArgsConstructor
public class NotificationsController {
    private final NotificationService notificationService;

    @PostMapping("")
    public ResponseEntity<?> createNotification(@RequestBody NotificationDTO notificationDTO) {
        notificationService.crateNotification(notificationDTO);
        return ResponseEntity.ok("create notification successfully");
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getNotificationById(@PathVariable long id) {
        return ResponseEntity.ok(notificationService.getNotificationById(id));
    }
}
