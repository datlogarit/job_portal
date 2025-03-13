package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;

@Data
public class CompanyDTO {
    @NotEmpty(message = "name can't is empty")
    private String name;

    @NotEmpty(message = "name can't is empty")
    private String location;

    @NotEmpty(message = "name can't is empty")
    private String introduction;

    @JsonProperty("avt_url")
    @NotEmpty(message = "name can't is empty")
    private String avtUrl;

    @NotEmpty(message = "phone number can't is empty")
//    @Min(value = 5, message = "the minimum length of phone number is 10 characters")
//    @Max(value = 11, message = "the maximum length of phone number is 11 characters")
    private String hotline;

    private boolean isActive;

}
