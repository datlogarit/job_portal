package com.project.jobportal.repositories;

import com.project.jobportal.models.Applications;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IApplicationRepository extends JpaRepository<Applications, Long> {
    @Override
    Page<Applications> findAll(Pageable pageable);
}
