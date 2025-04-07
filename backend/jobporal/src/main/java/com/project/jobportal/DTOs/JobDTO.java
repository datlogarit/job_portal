package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.Date;

@Data
public class JobDTO {
    @NotNull(message = "Title is required")
    private String title;

    @NotNull(message = "Salary range is required")
    @JsonProperty("min_salary")
    private int minSalary;

    @NotNull(message = "Salary range is required")
    @JsonProperty("max_salary")
    private int maxSalary;

    @NotNull(message = "Experience is required")
    private String experience;

    @NotNull(message = "Working time is required")
    @JsonProperty("working_time")
    private String workingTime;

    @NotNull(message = "Number of recruitment is required")
    @JsonProperty("number_recruitment")
    private int numberRecruitment;

    @NotNull(message = "gender is required")
    private String gender;

    @NotNull(message = "Position is required")
    private String position;

    @NotNull(message = "date is required")
    @JsonProperty("exp_date")
    private LocalDate expDate;

    @NotNull(message = "requirement is required")
    private String requirement;

    @NotNull(message = "description is required")
    private String description;

    @NotNull(message = "benefit is required")
    private String benefit;

    @NotNull(message = "work location is required")
    @JsonProperty("work_location")
    private String workLocation;

    @NotNull(message = " reporter is required")
    @JsonProperty("posted_by")
    private long postedBy;

    @NotNull(message = "category is required")
    @JsonProperty("category_id")
    private long categoryId;

    private String status;

    private int isEdit;

    private int isLock;

    private int isActive;
}
