package com.project.jobportal.models;

import com.project.jobportal.services.JobService;
import jakarta.persistence.*;
import lombok.*;

import java.util.Date;


@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
//@RequiredArgsConstructor
public class Users extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "dob")
    private Date dob;

    @Column(name = "role")
    private String role;

    @Column(name = "url_avatar")
    private String urlAvatar;

    @Column(name = "is_active")
    private int isActive;

}
