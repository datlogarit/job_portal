package com.project.jobportal.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.jobportal.models.RecruiterVerifications;

public interface IRecruiterVerificationRepository extends
        JpaRepository<RecruiterVerifications, Long> {

}
