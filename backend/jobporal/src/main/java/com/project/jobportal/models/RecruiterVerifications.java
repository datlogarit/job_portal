package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "recruiter_verifycations")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data

public class RecruiterVerifications extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "authorization_letter_url")
    private String authorizationLetterUrl;

    @Column(name = "business_license_url")
    private String businessLicenseUrl;

    @Column(name = "status")
    private int status;

    @Column(name = "reject_reason")
    private String rejectReason;
}
