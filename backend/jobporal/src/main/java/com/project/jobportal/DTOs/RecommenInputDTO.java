package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RecommenInputDTO {
    @JsonProperty(value = "user_id")
    private long userId;
    private String title;
    @JsonProperty(value = "category_id")
    private long categoryId;
    @JsonProperty(value = "work_location")
    private String workLocation;
    @JsonProperty(value = "total_jobs")
    private int totalJobs;
}
