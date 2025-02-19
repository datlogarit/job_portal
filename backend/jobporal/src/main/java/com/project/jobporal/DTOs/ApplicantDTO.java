package com.project.jobporal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.Data;
import org.apache.catalina.User;

@Data
public class ApplicantDTO {

    private long id;

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
