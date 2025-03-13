package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "recruiters")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Recruiters {
    @Id
    private long id;

    @MapsId
    @OneToOne
    @JoinColumn(name = "user_id")
    private Users userId;

    @OneToOne// chỉ định mối qh giữa các entity
    @JoinColumn(name = "company_id")//chỉ định cột chứa khóa ngoại
    private Companies companyId;

    @Column(name = "is_verify")
    private int isVerify;

    @Column(name = "number_of_post")
    private int numberOfPost;

    @Column(name = "position")
    private String position;
}
