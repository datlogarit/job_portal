package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@Table(name = "notifications")
@NoArgsConstructor
@AllArgsConstructor
@Data

public class Notifications extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "title")
    private String title;

    @Column(name = "content")
    private String content;

    @ManyToOne
    @JoinColumn(name = "job_related")
    private Jobs jobRelated;

    @ManyToOne
    @JoinColumn(name = "application_id")
    private Applications applicationId;

    @Column(name = "categories_notification")
    private String categoryNotification;
}
