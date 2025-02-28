package com.project.jobporal.services;

import com.project.jobporal.DTOs.NotiUserDTO;
import com.project.jobporal.models.NotiUserKey;
import com.project.jobporal.models.NotiUsers;
import com.project.jobporal.models.Users;

import java.util.List;

public interface INotiUserService {
    void createUserNoti(NotiUserDTO notiUserDTO);

    void updateUserNoti(NotiUserDTO notiUserDTO);

    List<NotiUsers> getNotiByUserId(long userId);
}
