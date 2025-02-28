package com.project.jobporal.services;

import com.project.jobporal.DTOs.NotificationDTO;
import com.project.jobporal.models.Notifications;

public interface INotificationService {
    void crateNotification(NotificationDTO notificationDTO);

    Notifications getNotificationById(long id);
}
