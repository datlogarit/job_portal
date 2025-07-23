package com.project.jobportal.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.jobportal.models.Users;
import lombok.*;
import org.springframework.security.core.userdetails.UserDetails;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LoginResponse {
    @JsonProperty("user")
    private UserDetails user;
    @JsonProperty("token")
    private String token;
}
