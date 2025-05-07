package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import lombok.*;

@Data
public class CompanyDTO {

    @JsonProperty("tax_code")
    private String taxCode;

    private String name;

    private String website;

    private String scale;

    private String address;

    private String email;

    private String hotline;

//    private String location;

    private String introduction;

    @JsonProperty("avt_url")
    private String avtUrl;
    
    private boolean isActive;

}
