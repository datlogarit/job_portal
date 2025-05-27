package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class InviteDTO {
    @JsonProperty("job_id")
    private long jobId;

    @JsonProperty("applicant_id")
    private long applicantId;

    private int status;
}
