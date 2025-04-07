package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class ApplicationDTO {
    @JsonProperty("applicant_id")
    private long applicantId;

    @JsonProperty("job_id")
    private long jobId;

    @JsonProperty("status_apply")
    private String statusApply;

    @JsonProperty("full_name")
    private String fullName;

    @JsonProperty("email")
    private String email;

    @JsonProperty("phone_number")
    private String phoneNumber;

//    @JsonProperty("cv_url")
//    private String cvUrl;

    @JsonProperty("message")
    private String message;
}
