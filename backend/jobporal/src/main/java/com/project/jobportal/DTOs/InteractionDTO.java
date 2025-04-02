package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class InteractionDTO {
    @JsonProperty("applicant_id")
    private long applicantId;

    @JsonProperty("job_id")
    private long jobId;

    @JsonProperty("is_save")
    private int isSaved;

    @JsonProperty("is_read")
    private int isRead;

}
