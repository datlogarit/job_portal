package com.project.jobporal.DTOs;

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

    @NotEmpty(message = "name can't is empty")
    private String hotline;

    private boolean isActive ;

}
