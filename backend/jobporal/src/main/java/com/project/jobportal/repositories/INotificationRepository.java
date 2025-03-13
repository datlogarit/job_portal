package com.project.jobportal.repositories;

import com.project.jobportal.models.Notifications;
import org.springframework.data.jpa.repository.JpaRepository;

public interface INotificationRepository extends JpaRepository<Notifications, Long> {
}
