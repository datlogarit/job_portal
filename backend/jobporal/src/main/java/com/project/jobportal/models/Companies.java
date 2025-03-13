package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "companies")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Companies {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "company_name", nullable = false, length = 50)
    private String name;

    @Column(name = "company_location", nullable = false, length = 100)
    private String location;

    @Column(name = "introduction", nullable = false)
    private String introduction;

    @Column(name = "url_avatar", nullable = false)
    private String url_avt;

    @Column(name = "hotline", nullable = false, length = 50)
    private String hotline;
}
