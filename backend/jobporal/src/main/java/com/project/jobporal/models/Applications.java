package com.project.jobporal.models;

import jakarta.annotation.Generated;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Table(name = "applications")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Applications extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @Column(name = "applicant_id", nullable = false)
    private Applicants applicantId;

    @ManyToOne
    @Column(name = "job_id", nullable = false)
    private Jobs jobId;

    @Column(name = "status_apply")
    private String statusApply;

    @Column(name = "is_saved")
    private int isSaved;

    @Column(name = "is_read")
    private int isRead;
}
