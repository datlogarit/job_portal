package com.project.jobporal.models;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;

@Entity//xac dinh class duoc anh xa toi 1 bang trong db
@Table(name = "categories")//xac dinh bang ma class se anh xa toi
@Data
@AllArgsConstructor//khoi tạo doi tuong de nhan vao info
@NoArgsConstructor//bat buoc phai có constructor khong tham so de Hibernate co the khoi tao doi tuong
@Builder// dung de khoi tao doi tuong,dung Builder Pattern chu khong dung constructor de khoi tao doi tuong
public class Categories {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;// anh xa cot id voi cot id trong db

    @Column(name = "name", nullable = false, unique = true, length = 50)
    private String name;

}
