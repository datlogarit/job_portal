package com.project.jobportal.repositories;

import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface IApplicantRepository extends JpaRepository<Applicants, Long> {
    @Override
    Page<Applicants> findAll(Pageable pageable);

    @Query("SELECT u FROM Users u WHERE u.email = :email")
    Users findByEmail(@Param("email") String email);
}
