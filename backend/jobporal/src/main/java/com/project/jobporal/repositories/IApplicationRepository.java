package com.project.jobporal.repositories;

import com.project.jobporal.models.Applications;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IApplicationRepository extends JpaRepository<Applications, Long> {
    @Override
    Page<Applications> findAll(Pageable pageable);
}
