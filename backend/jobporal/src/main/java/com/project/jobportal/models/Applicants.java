package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "applicants")
@Data // toString
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Applicants {
    @Id
    private long id;

    @MapsId
    @OneToOne
    @JoinColumn(name = "user_id")
    private Users userId;

    @Column(name = "resume")
    private String resume;

    @Column(name = "gender")
    private String gender;

    @Column(name = "working_time")
    private String workingTime;

    @ManyToOne
    @JoinColumn(name = "field")
    private Categories field;

    @Column(name = "desired_position")
    private String desiredPosition;

    @Column(name = "desired_location")
    private String desiredLocation;

    @Column(name = "current_position")
    private String currentPosition;

    @Column(name = "work_experience")
    private String workExperience;

    @Column(name = "skills")
    private String skills;
}
