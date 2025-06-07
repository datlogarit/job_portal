package com.project.jobportal.repositories;

import com.project.jobportal.models.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface IUserRepository extends JpaRepository<Users, Long> {
    @Override
    Page<Users> findAll(Pageable pageable);

    boolean existsByPhoneNumber(String phoneNumber);

    Users findByEmailAndPasswordAndRole(String email, String password, String role);

    Optional<Users> findByEmail(String email);
}
