package com.project.jobportal.repositories;

import com.project.jobportal.models.Applicants;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IApplicantRepository extends JpaRepository<Applicants, Long> {
    @Override
    Page<Applicants> findAll(Pageable pageable);
}
