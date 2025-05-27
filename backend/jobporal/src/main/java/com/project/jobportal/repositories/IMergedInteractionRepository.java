package com.project.jobportal.repositories;

import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.MergedInteraction;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface IMergedInteractionRepository extends JpaRepository<MergedInteraction, Long> {
    @Query("SELECT mi FROM MergedInteraction mi " +
            "WHERE mi.applicantId = :applicantId " +//tìm những job theo applicant và kh lock
            "AND mi.jobId.isLock = 0")
    List<MergedInteraction> findByApplicantId(Applicants applicantId, Sort sort);
}
