package com.project.jobportal.models;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Embeddable
public class NotiUserKey {
    private Long IdNoti;
    private Long IdUser;
}
