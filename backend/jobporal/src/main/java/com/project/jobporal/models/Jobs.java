package com.project.jobporal.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Entity
@Table(name = "jobs")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Jobs extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "title")
    private String title;

    @Column(name = "salary_range")
    private String salaryRange;

    @Column(name = "experience")
    private String experience;

    @Column(name = "working_time")
    private String workingTime;

    @Column(name = "number_recruitment")
    private int numberRecruitment;

    @Column(name = "gender")
    private String gender;

    @Column(name = "position")
    private String position;

    @Column(name = "exp_date")
    private Date expDate;

    @Column(name = "requirement")
    private String requirement;

    @Column(name = "description")
    private String description;

    @Column(name = "benefit")
    private String benefit;

    @Column(name = "work_location")
    private String workLocation;

    @ManyToOne
    @JoinColumn(name = "posted_by")
    private Recruiters postedBy;

    @ManyToOne
    @JoinColumn(name = "company_id")
    private Companies companyId;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Categories categoryId;

    @Column(name = "status")
    private String status;

    @Column(name = "is_edit")
    private int isEdit;

    @Column(name = "is_lock")
    private int isLock;

    @Column(name = "is_active")
    private int isActive;
}
