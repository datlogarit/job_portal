package com.project.jobporal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RecruiterVerificationDTO {
    @JsonProperty("recruiter_id")
    private long RecruiterId;

    @JsonProperty("authorization_letter_url")
    private String authorizationLetterUrl;

    @JsonProperty("business_license_url")
    private String businessLicenseUrl;

    private int status;

    @JsonProperty("reject_reason")
    private String rejectReason;
}
