package com.project.jobportal.repositories;

import com.project.jobportal.models.Interactions;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface IInteractionRepository extends JpaRepository<Interactions, Long> {
    @Override
    Page<Interactions> findAll(Pageable pageable);

    @Query("SELECT i FROM Interactions i WHERE i.applicantId.userId.id = :applicantId AND i.jobId.id = :jobId")
    Optional<Interactions> finByApplicantIdAndJobId(@Param("applicantId") long applicantId, @Param("jobId") long jobId);
}
