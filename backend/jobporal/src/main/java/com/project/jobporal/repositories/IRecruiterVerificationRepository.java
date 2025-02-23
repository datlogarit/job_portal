package com.project.jobporal.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.jobporal.models.RecruiterVerifications;

public interface IRecruiterVerificationRepository extends JpaRepository<RecruiterVerifications, Long> {

}
