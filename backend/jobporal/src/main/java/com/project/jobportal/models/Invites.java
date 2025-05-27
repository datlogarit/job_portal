package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

//@Data
@Entity
@Table(name = "invites")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Getter
@Setter
public class Invites extends BaseEntity {
    @EmbeddedId
    private InviteKey id;

    @ManyToOne
    @MapsId("jobId")
    @JoinColumn(name = "job_id")
    private Jobs jobId;

    @ManyToOne
    @MapsId("applicantId")
    @JoinColumn(name = "applicant_id")
    private Applicants applicantId;

    @JoinColumn(name = "status")
    private int status;
}
