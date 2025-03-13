package com.project.jobportal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "noti_users")
@Builder
public class NotiUsers {
    @EmbeddedId
    private NotiUserKey id;//khoá chính đây - phải đươc truền vào tu service

    @ManyToOne
    @MapsId("IdNoti")//ánh xạ IdNoti từ NotiUserKey vào bang
    @JoinColumn(name = "id_noti")
    private Notifications idNoti;

    @ManyToOne
    @MapsId("IdUser")
    @JoinColumn(name = "id_user")
    private Users idUser;

    @Column(name = "is_read")
    private int isRead;
}