package com.project.jobporal.repositories;

import com.project.jobporal.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IUserRepository extends JpaRepository<Users, Long> {
}
