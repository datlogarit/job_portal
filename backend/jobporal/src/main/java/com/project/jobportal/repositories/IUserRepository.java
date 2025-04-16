package com.project.jobportal.repositories;

import com.project.jobportal.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IUserRepository extends JpaRepository<Users, Long> {

    boolean existsByPhoneNumber(String phoneNumber);

    Users findByEmailAndPasswordAndRole(String email, String password, String role);
}
