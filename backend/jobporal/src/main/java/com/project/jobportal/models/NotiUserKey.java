package com.project.jobportal.models;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class NotiUserKey {
    private Long IdNoti;
    private Long IdUser;
}
