package com.project.jobportal.DTOs;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.validation.constraints.Min;
import lombok.Data;

@Data
public class NotiUserDTO {
    @Min(value = 1, message = "Id notification must be greater than 0")
    @JsonProperty("id_user")
    private long idUser;

    @Min(value = 1, message = "Id user must be greater than 0")
    @JsonProperty("id_noti")
    private long idNoti;

    @JsonProperty("is_read")
    private int isRead;

}
