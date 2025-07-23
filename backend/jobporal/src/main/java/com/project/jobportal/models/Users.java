package com.project.jobportal.models;

import com.project.jobportal.services.JobService;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDate;
import java.util.*;


@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
//@RequiredArgsConstructor
public class Users extends BaseEntity implements UserDetails {//user > userdetail
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
    private LocalDate dob;

    @Column(name = "role")
    private String role;

    @Column(name = "url_avatar")
    private String urlAvatar;

    @Column(name = "is_active")
    private int isActive;

    //required
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // SimpleGrantedAuthority authorityList = new SimpleGrantedAuthority("ROLE_" + this.role.toUpperCase());
        // TODO: return roles or permission of user
        return List.of(new SimpleGrantedAuthority("ROLE_" + this.getRole().toUpperCase()));
    }

    @Override
    public String getUsername() {
        return this.email;// TODO: return username;
    }

    @Override
    public String getPassword() {
        return this.password;// TODO: return username;
    }

    //optional
    @Override
    public boolean isAccountNonExpired() {
        return UserDetails.super.isAccountNonExpired();
    }

    @Override
    public boolean isAccountNonLocked() {
        return UserDetails.super.isAccountNonLocked();
    }

    @Override
    public boolean isCredentialsNonExpired() {// Thông tin xác thực
        return UserDetails.super.isCredentialsNonExpired();
    }

    @Override
    public boolean isEnabled() {
        return UserDetails.super.isEnabled();
    }
}
