package com.project.jobporal.models;

// import java.io.Serializable;

import jakarta.persistence.*;
import lombok.*;

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

    @Column(name = "profession")
    private String profession;

    @Column(name = "desired_position")
    private String desiredPosition;

    @Column(name = "desired_location")
    private String desiredLocation;

    @Column(name = "work_experience")
    private String workExperience;

}
