package com.project.jobporal.repositories;

import com.project.jobporal.models.Recruiters;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IRecruiterRepository extends JpaRepository<Recruiters, Long> {
}
