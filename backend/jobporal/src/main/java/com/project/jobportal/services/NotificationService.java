package com.project.jobportal.services;

import com.project.jobportal.DTOs.NotificationDTO;
import com.project.jobportal.models.*;
import com.project.jobportal.repositories.IInteractionRepository;
import com.project.jobportal.repositories.INotiUserRepository;
import com.project.jobportal.repositories.INotificationRepository;
import com.project.jobportal.repositories.IUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationService implements INotificationService {
    private final INotificationRepository iNotificationRepository;
    private final IInteractionRepository iInteractionRepository;
    private final INotiUserRepository iNotiUserRepository;
    private final IUserRepository iUserRepository;
    private final JobService jobService;
    private final InteractionService applicationService;

    @Override
    public void crateNotification(NotificationDTO notificationDTO) {
        Jobs jobs = jobService.getJobById(notificationDTO.getJobRelated());
//        Interactions interactions = applicationService.getInteractionById(notificationDTO.getApplicationId());
        Notifications newNotification = Notifications.builder()
                .title(notificationDTO.getTitle())
                .content(notificationDTO.getContent())
                .jobRelated(jobs)
//                .applicationId(interactions)
                .categoryNotification(notificationDTO.getCategoryNotification())
                .build();
        iNotificationRepository.save(newNotification);
    }

    @Override
    public Notifications getNotificationById(long id) {
        return iNotificationRepository.findById(id).orElseThrow(() -> new RuntimeException("notification not found"));
    }


    //hàm chạy tự động mỗi ngày. dùng để ktra công việc sắp hết hạn và thông báo cho user
    @Scheduled(cron = "0 0 6 * * ?") // Chạy lúc 6h sáng mỗi ngày
    public void notifyExpiringJobs() {
        LocalDate threeDaysLater = LocalDate.now().plusDays(5);//5 ngày sau ngày chỉ định
        List<Interactions> interactionsSaved = iInteractionRepository.findByIsSaved(1).orElseThrow(() ->
                new RuntimeException("interaction not found")); //tìm nhưững iteraction mà co trang thai isSave = 1;

        for (Interactions interaction : interactionsSaved) {
            Jobs jobs = jobService.getJobById(interaction.getJobId().getId());// co job roi bay h check roi gui thong bao la xong
            if (jobs != null && jobs.getExpDate().compareTo(threeDaysLater) == 0) {
                Notifications notifications = Notifications.builder()
                        .title("Công việc sắp hết hạn")
                        .content("Công việc " + jobs.getTitle() + " mà bạn đã lưu sắp hết hạn, nhanh tay ứng tuyển ngay")
                        .jobRelated(jobs)
                        .categoryNotification("expired")
                        .build();
                iNotificationRepository.save(notifications);
                Users users = iUserRepository.findById(interaction.getApplicantId().getId()).orElseThrow(() ->
                        new RuntimeException("user not found"));
                NotiUserKey notiUserKey = new NotiUserKey(notifications.getId(), users.getId());

                NotiUsers notiUsers = NotiUsers.builder()
                        .id(notiUserKey)
                        .idNoti(notifications)
                        .idUser(users)
                        .isRead(0)
                        .build();
                iNotiUserRepository.save(notiUsers);
            }
        }
    }
}
