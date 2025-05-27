package com.project.jobportal.repositories;

import com.project.jobportal.models.NotiUserKey;
import com.project.jobportal.models.NotiUsers;
import com.project.jobportal.models.Users;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface INotiUserRepository extends JpaRepository<NotiUsers, NotiUserKey> {

    List<NotiUsers> findByIdUser(Users userId, Sort sort);
}
