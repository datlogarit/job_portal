package com.project.jobportal.repositories;

import com.project.jobportal.models.Applications;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import javax.swing.text.html.Option;
import java.util.Optional;

public interface IApplicationRepository extends JpaRepository<Applications, Long> {
    @Override
    Page<Applications> findAll(Pageable pageable);

    @Query("SELECT a FROM Applications a WHERE a.applicantId.userId.id = :applicantId AND a.jobId.id = :jobId")
    Optional<Applications> finByApplicantIdAndJobId(@Param("applicantId") long applicantId, @Param("jobId") long jobId);
}
