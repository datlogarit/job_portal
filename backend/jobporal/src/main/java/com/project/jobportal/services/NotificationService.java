package com.project.jobportal.services;

import com.project.jobportal.DTOs.NotificationDTO;
import com.project.jobportal.models.Interactions;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.models.Notifications;
import com.project.jobportal.repositories.INotificationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class NotificationService implements INotificationService {
    private final INotificationRepository iNotificationRepository;
    private final JobService jobService;
    private final InteractionService applicationService;

    @Override
    public void crateNotification(NotificationDTO notificationDTO) {
        Jobs jobs = jobService.getJobById(notificationDTO.getJobRelated());
        Interactions interactions = applicationService.getInteractionById(notificationDTO.getApplicationId());
        Notifications newNotification = Notifications.builder()
                .title(notificationDTO.getTitle())
                .content(notificationDTO.getContent())
                .jobRelated(jobs)
                .applicationId(interactions)
                .categoryNotification(notificationDTO.getCategoryNotification())
                .build();
        iNotificationRepository.save(newNotification);
    }

    @Override
    public Notifications getNotificationById(long id) {
        return iNotificationRepository.findById(id).orElseThrow(() -> new RuntimeException("notification not found"));
    }
}
