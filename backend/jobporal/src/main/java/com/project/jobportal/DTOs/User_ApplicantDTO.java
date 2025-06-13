package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Data
public class User_ApplicantDTO {
    @NotEmpty(message = "name is required")
    private String name;

    @NotEmpty(message = "email is required")
    private String email;

    @NotEmpty(message = "password is required")
    private String password;

    //    @NotEmpty(message = "phoneNumber is required")
    @JsonProperty("phone_number")
    private String phoneNumber;

    private LocalDate dob;

    private String role;

    @JsonProperty("url_avatar")
    private String urlAvatar;

    @JsonProperty("is_active")
    private Long isActive;

    private String resume;

    private String gender;

    @JsonProperty("working_time")
    private String workingTime;

    private Long field;

    @JsonProperty("desired_position")
    private String desiredPosition;

    @JsonProperty("desired_location")
    private String desiredLocation;

    @JsonProperty("current_position")
    private String currentPosition;

    @JsonProperty("work_experience")
    private String workExperience;

    private String skills;
}
