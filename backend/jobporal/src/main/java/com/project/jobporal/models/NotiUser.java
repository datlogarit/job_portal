package com.project.jobporal.models;

import jakarta.persistence.Column;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "noti_user")
public class NotiUser {
    @ManyToOne
    @Column(name = "id_noti")
    private Notifications idNoti;

    @ManyToOne
    @Column(name = "id_user")
    private Users idUser;

    @Column(name = "is_read")
    private int isRead;
}