package com.project.jobporal.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
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
