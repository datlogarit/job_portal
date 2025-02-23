package com.project.jobporal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ApplicationDTO {
    @JsonProperty("application_id")
    private long applicationId;

    @JsonProperty("job_id")
    private long jobId;

    @JsonProperty("status_apply")
    private String statusApply;

    @JsonProperty("is_saved")
    private int isSaved;

    @JsonProperty("is_read")
    private int isRead;

}
