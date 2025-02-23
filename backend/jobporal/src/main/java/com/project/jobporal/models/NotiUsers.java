package com.project.jobporal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "noti_users")

public class NotiUsers {
    @Id
    private long id;

    @ManyToOne
    @JoinColumn(name = "id_noti")
    private Notifications idNoti;

    @ManyToOne
    @JoinColumn(name = "id_user")
    private Users idUser;

    @Column(name = "is_read")
    private int isRead;
}