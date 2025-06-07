package com.project.jobportal.repositories;

import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Recruiters;
import com.project.jobportal.models.Users;
import org.springframework.boot.ApplicationArguments;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface IApplicantRepository extends JpaRepository<Applicants, Long> {
    @Override
    Page<Applicants> findAll(Pageable pageable);

    @Query("SELECT a FROM Applicants a WHERE a.userId.email = :email")
    Applicants findByEmail(@Param("email") String email);

    @Query("SELECT a FROM Applicants a WHERE a.userId.email = :email AND a.userId.password = :password" +
            " AND a.userId.role = 'applicant'")
    Applicants login(@Param("email") String email, @Param("password") String password);
}
