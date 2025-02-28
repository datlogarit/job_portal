package com.project.jobporal.repositories;

import com.project.jobporal.models.NotiUserKey;
import com.project.jobporal.models.NotiUsers;
import com.project.jobporal.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface INotiUserRepository extends JpaRepository<NotiUsers, NotiUserKey> {
    List<NotiUsers> findByIdUser(Users userId);
}
