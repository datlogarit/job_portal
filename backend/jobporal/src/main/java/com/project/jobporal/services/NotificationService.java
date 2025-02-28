package com.project.jobporal.services;

import com.project.jobporal.DTOs.NotificationDTO;
import com.project.jobporal.models.Applications;
import com.project.jobporal.models.Jobs;
import com.project.jobporal.models.Notifications;
import com.project.jobporal.repositories.INotificationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class NotificationService implements INotificationService {
    private final INotificationRepository iNotificationRepository;
    private final JobService jobService;
    private final ApplicationService applicationService;

    @Override
    public void crateNotification(NotificationDTO notificationDTO) {
        Jobs jobs = jobService.getJobById(notificationDTO.getJobRelated());
        Applications applications = applicationService.getApplicationById(notificationDTO.getApplicationId());
        Notifications newNotification = Notifications.builder()
                .title(notificationDTO.getTitle())
                .content(notificationDTO.getContent())
                .jobRelated(jobs)
                .applicationId(applications)
                .build();
        iNotificationRepository.save(newNotification);
    }

    @Override
    public Notifications getNotificationById(long id) {
        return iNotificationRepository.findById(id).orElseThrow(() -> new RuntimeException("notification not found"));
    }
}
