package com.project.jobportal.services;

import com.project.jobportal.DTOs.NotiUserDTO;
import com.project.jobportal.models.NotiUsers;

import java.util.List;

public interface INotiUserService {
    void createUserNoti(NotiUserDTO notiUserDTO);

    void updateUserNoti(NotiUserDTO notiUserDTO);

    List<NotiUsers> getNotiByUserId(long userId);

    int getTotalUnReadNotiByUserId(long userId);
}
