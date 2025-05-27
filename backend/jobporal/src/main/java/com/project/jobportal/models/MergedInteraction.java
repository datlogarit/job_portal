package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "merged_interactions")
public class MergedInteraction {

    @Id
    @Column(name = "id") // hoặc một cột duy nhất đại diện (bắt buộc cần @Id cho JPA)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "applicant_id")
    private Applicants applicantId;

    @ManyToOne
    @JoinColumn(name = "job_id")
    private Jobs jobId;

    @Column(name = "status_apply")
    private String statusApply;//Pending, Approved, Rejected

    @Column(name = "is_save")
    private Long isSave;

    @Column(name = "is_read")
    private Long isRead;

    @Column(name = "is_lock")
    private Long isLock;

    @Column(name = "status")
    private String status;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
}
