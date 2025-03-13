package com.project.jobportal.repositories;

import com.project.jobportal.models.Recruiters;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface IRecruiterRepository extends JpaRepository<Recruiters, Long> {
    @Override
    Page<Recruiters> findAll(Pageable pageable);

    @Query("SELECT r FROM Recruiters r WHERE r.companyId.id = :companyId")
    Optional<Recruiters> finRecruiterByCompanyId(@Param("companyId") long companyId);
}
