package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class NotificationDTO {
    private String title;

    private String content;

    @JsonProperty(value = "job_related")
    private long jobRelated;

    @JsonProperty(value = "application_id")
    private long applicationId;
}
