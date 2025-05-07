package com.project.jobportal.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.jobportal.models.RecruiterVerifications;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IRecruiterVerificationRepository extends
        JpaRepository<RecruiterVerifications, Long> {
//    @Query("SELECT r FROM RecruiterVerifications r WHERE r.recruiterId.userId.email = :email")
//    RecruiterVerifications findByEmail(@Param("email") String email);
}
