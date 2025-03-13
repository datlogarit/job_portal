package com.project.jobportal.services;

import com.project.jobportal.DTOs.NotificationDTO;
import com.project.jobportal.models.Notifications;

public interface INotificationService {
    void crateNotification(NotificationDTO notificationDTO);

    Notifications getNotificationById(long id);
}
