package com.project.jobportal.services;

import com.project.jobportal.DTOs.InviteDTO;
import com.project.jobportal.models.*;
import com.project.jobportal.repositories.IInviteRepository;
import com.project.jobportal.repositories.INotiUserRepository;
import com.project.jobportal.repositories.INotificationRepository;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class InviteService implements IInviteService {
    private final IInviteRepository iInviteRepository;
    private final IJobService iJobService;
    private final IApplicantService iApplicantService;
    private final INotificationRepository iNotificationRepository;
    private final IUserService iUserService;
    private final INotiUserRepository iNotiUserRepository;

    @Override
    public void createInvite(InviteDTO inviteDTO) {
        InviteKey inviteKey = new InviteKey(inviteDTO.getJobId(), inviteDTO.getApplicantId());
        Jobs job = iJobService.getJobById(inviteDTO.getJobId());
        Applicants applicants = iApplicantService.getApplicantById(inviteDTO.getApplicantId());
        Users users = iUserService.getUserById(inviteDTO.getApplicantId());
        Invites invites = Invites.builder()
                .id(inviteKey)
                .jobId(job)
                .applicantId(applicants)
                .status(0)
                .build();
        iInviteRepository.save(invites);
        //Mời xong thì tạo thông báo cho user
        //Create notification
        Notifications notifications = Notifications.builder()
                .title("Invitation to apply")
                .categoryNotification("invite apply")
                .jobRelated(job)
                .content("You are invited to apply for a job: " + "\"" + job.getTitle() + "\"" + " check it out now!")
                .build();
        iNotificationRepository.save(notifications);
        //assign notification for user
        NotiUserKey notiUserKey = new NotiUserKey(inviteDTO.getJobId(), inviteDTO.getApplicantId());
        NotiUsers notiUsers = NotiUsers.builder()
                .id(notiUserKey)
                .idNoti(notifications)
                .idUser(users)
                .isRead(0)
                .build();
        iNotiUserRepository.save(notiUsers);
    }
}
