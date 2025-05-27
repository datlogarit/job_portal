package com.project.jobportal.models;

import java.time.LocalDate;
import java.util.Date;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "jobs")
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@EqualsAndHashCode
public class Jobs extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "title")
    private String title;

    @Column(name = "min_salary")
    private int minSalary;

    @Column(name = "max_salary")
    private int maxSalary;

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
    private LocalDate expDate;

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
    @JoinColumn(name = "category_id")
    private Categories categoryId;

    @Column(name = "status")
    private String status;

//    @Column(name = "is_edit")
//    private int isEdit;

    @Column(name = "is_lock")
    private long isLock;

//    @Column(name = "is_active")
//    private int isActive;
}
