package com.project.jobporal.services;

import com.project.jobporal.DTOs.NotiUserDTO;
//import com.project.jobporal.models.NotiUserKey;
import com.project.jobporal.models.NotiUserKey;
import com.project.jobporal.models.NotiUsers;
import com.project.jobporal.models.Notifications;
import com.project.jobporal.models.Users;
import com.project.jobporal.repositories.INotiUserRepository;
import com.project.jobporal.repositories.IUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotiUserService implements INotiUserService {
    private final INotiUserRepository iNotiUserRepository;
    private final IUserRepository iUserRepository;
    private final NotificationService notificationService;

    @Override
    public void createUserNoti(NotiUserDTO notiUserDTO) {
        NotiUserKey notiUserKey = new NotiUserKey(notiUserDTO.getIdNoti(), notiUserDTO.getIdUser());

        Users users = iUserRepository.findById(notiUserDTO.getIdUser()).orElseThrow(() -> new RuntimeException("user not found"));
        Notifications notifications = notificationService.getNotificationById(notiUserDTO.getIdNoti());
        NotiUsers notiUsers = NotiUsers.builder()
                .id(notiUserKey)
                .idUser(users)
                .idNoti(notifications)
                .isRead(0)
                .build();
        iNotiUserRepository.save(notiUsers);
    }

    @Override//khi truyen DTO, service se tu biet update cai gi
    public void updateUserNoti(NotiUserDTO notiUserDTO) {
        NotiUserKey notiUserKey = new NotiUserKey(notiUserDTO.getIdNoti(), notiUserDTO.getIdUser());
        NotiUsers notiUsers = iNotiUserRepository.findById(notiUserKey).orElseThrow(
                () -> new RuntimeException("noti user not found"));
        notiUsers.setIsRead(notiUserDTO.getIsRead());
        iNotiUserRepository.save(notiUsers);
    }

    @Override
    public List<NotiUsers> getNotiByUserId(long userId) {
        Users users = iUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("user not found"));
        return iNotiUserRepository.findByIdUser(users);
    }
}
