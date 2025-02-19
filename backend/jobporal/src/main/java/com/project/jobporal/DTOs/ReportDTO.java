package com.project.jobporal.DTOs;

import lombok.Data;

@Data
public class ReportDTO {
    private long reported_job;

    private long reported_by;

    private String reason;
}
