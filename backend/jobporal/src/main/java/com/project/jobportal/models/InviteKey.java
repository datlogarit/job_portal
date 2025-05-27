package com.project.jobportal.models;

import jakarta.persistence.Embeddable;
import lombok.*;

@Data
@Embeddable
@AllArgsConstructor
@NoArgsConstructor
public class InviteKey {
    private Long jobId;
    private Long applicantId;
}
