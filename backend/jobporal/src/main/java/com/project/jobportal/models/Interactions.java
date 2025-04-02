package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "interactions")
@Data // toString, equals, hashCode, getter, setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Interactions extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "applicant_id")
    private Applicants applicantId;

    @ManyToOne
    @JoinColumn(name = "job_id")
    private Jobs jobId;

    @Column(name = "is_save")
    private int isSaved;

    @Column(name = "is_read")
    private int isRead;
}
