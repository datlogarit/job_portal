package com.project.jobporal.models;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

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

    @ManyToOne
    @JoinColumn(name = "reported_job")
    private Jobs reportedJob;

    @ManyToOne
    @JoinColumn(name = "reporter")
    private Applicants reporter;

    @Column(name = "reason")
    private String reason;

    @Column(name = "is_solve")
    private long isSolve;
}
