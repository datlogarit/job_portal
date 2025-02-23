package com.project.jobporal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "reports")

public class Reports extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "reported_job")
    private Jobs reportedJob;

    @Column(name = "reporter")
    private Applicants reporter;

    @Column(name = "reason")
    private String reason;

    @Column(name = "is_solve")
    private long isSolve;
}
