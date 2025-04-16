package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.time.LocalDate;

@Data
public class UserDTO {
    private String email;
    private String password;
    private String name;
    @JsonProperty("phone_number")
    private String phoneNumber;

    private LocalDate dob;


}
