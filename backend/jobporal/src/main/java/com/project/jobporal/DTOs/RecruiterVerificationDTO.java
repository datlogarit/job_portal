package com.project.jobporal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RecruiterVerificationDTO {
    @JsonProperty("recruiter_id")
    private long recruiterId;

    @JsonProperty("authorization_letter_url")
    private String authorizationLetterUrl;

    @JsonProperty("business_license_url")
    private String businessLicenseUrl;

    private int status;

    @JsonProperty("reject_reason")
    private String rejectReason;
}
