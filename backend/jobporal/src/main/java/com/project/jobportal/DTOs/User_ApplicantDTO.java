package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.Date;

@Data
public class User_ApplicantDTO {
    @NotEmpty(message = "name is required")
    private String name;

    @NotEmpty(message = "email is required")
    private String email;

    @NotEmpty(message = "password is required")
    private String password;

    @NotEmpty(message = "phoneNumber is required")
    @JsonProperty("phone_number")
    private String phoneNumber;

    private Date dob;

    private String role;

    @JsonProperty("url_avatar")
    private String urlAvatar;

    @JsonProperty("is_active")
    private int isActive;

    private String resume;

    private String gender;

    @JsonProperty("working_time")
    private String workingTime;

    private String profession;

    @JsonProperty("desired_position")
    private String desiredPosition;

    @JsonProperty("desired_location")
    private String desiredLocation;

    @JsonProperty("work_experience")
    private String workExperience;
}
