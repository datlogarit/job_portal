package com.project.jobporal.models;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Table(name = "recruiter_verifications")
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RecruiterVerifications {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "recruiter_id", nullable = false)
    private Recruiters recruiterId;

    @Column(name = "authorization_letter_url")
    private String authorizationLetterUrl;

    @Column(name = "business_license_url")
    private String businessLicenseUrl;

    @Column(name = "status")
    private int status;

    @Column(name = "reject_reason")
    private String rejectReason;
}
