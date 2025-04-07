package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "applications")
@Data // toString, equals, hashCode, getter, setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Applications extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "applicant_id")
    private Applicants applicantId;

    @ManyToOne
    @JoinColumn(name = "job_id")
    private Jobs jobId;

    @Column(name = "status_apply")
    private String statusApply;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "email")
    private String email;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "cv_url")
    private String cvUrl;

    @Column(name = "message")
    private String message;
}
