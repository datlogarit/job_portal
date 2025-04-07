package com.project.jobportal.repositories;

import com.project.jobportal.models.Applications;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface IApplicationRepository extends JpaRepository<Applications, Long> {
    @Query("SELECT a FROM Applications a WHERE a.applicantId.userId.id = :applicantId AND a.jobId.id = :jobId")
    Optional<Applications> finByApplicantIdAndJobId(@Param("applicantId") long applicantId, @Param("jobId") long jobId);

    @Query("SELECT a FROM Applications a WHERE a.applicantId.userId.id = :applicantId")
    Optional<List<Applications>> finByApplicantId(@Param("applicantId") long applicantId);
}
