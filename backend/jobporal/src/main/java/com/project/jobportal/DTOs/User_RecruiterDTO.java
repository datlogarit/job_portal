package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.Date;

@Data
public class User_RecruiterDTO {
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

    private int isActive;

    @JsonProperty("company_id")
    private long companyId;

    @JsonProperty("is_verify")
    private int isVerify;

    @JsonProperty("number_of_post")
    private int numberOfPost;

    private String position;
}
