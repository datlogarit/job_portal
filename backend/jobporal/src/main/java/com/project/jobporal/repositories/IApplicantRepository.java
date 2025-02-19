package com.project.jobporal.repositories;

import com.project.jobporal.models.Applicants;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IApplicantRepository extends JpaRepository<Applicants, Long> {
}
