package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.validation.constraints.Min;
import lombok.Data;

@Data
public class ReportDTO {
    @Min(value = 1, message = "id of reported job must be greater than 0")
    @JsonProperty("reported_job")
    private long reportedJob;

    @Min(value = 1, message = "id of reporter must be greater than 0")
    private long reporter;

    private String reason;

    @JsonProperty("is_solve")
    private int isSolve;
}
