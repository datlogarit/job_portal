package com.project.jobporal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class RecruiterDTO {
    @JsonProperty("user_id")
    private long userId;

    @JsonProperty("company_id")
    private long companyId;

    @JsonProperty("is_verify")
    private int isVerify;

    @JsonProperty("number_of_post")
    private int numberOfPost;

    private String position;
}
