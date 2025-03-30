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

    @JsonProperty("is_save")
    private int isSaved;

    @JsonProperty("is_read")
    private int isRead;


}
