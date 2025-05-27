package com.project.jobportal.repositories;

import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.InviteKey;
import com.project.jobportal.models.Invites;
import com.project.jobportal.models.Jobs;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IInviteRepository extends JpaRepository<Invites, InviteKey> {
    boolean existsByJobIdAndApplicantId(Jobs jobId, Applicants applicantId);
}
