package com.project.jobporal.repositories;

import com.project.jobporal.models.Recruiters;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IRecruiterRepository extends JpaRepository<Recruiters, Long> {
    @Override
    Page<Recruiters> findAll(Pageable pageable);
}
