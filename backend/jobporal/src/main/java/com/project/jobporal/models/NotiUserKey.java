package com.project.jobporal.models;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class NotiUserKey implements Serializable {
    private Long IdNoti;
    private Long IdUser;
}
