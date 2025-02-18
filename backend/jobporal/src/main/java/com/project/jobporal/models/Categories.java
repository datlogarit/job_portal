package com.project.jobporal.models;

import jakarta.persistence.*;
import lombok.*;

@Entity//xac dinh class duoc anh xa toi 1 bang trong db
@Table(name = "categories")//xac dinh bang ma class se anh xa toi
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder// dung de khoi tao doi tuong,dung Builder Pattern chu khong dung constructor de khoi tao doi tuong
public class Categories {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;// anh xa cot id voi cot id trong db

    @Column(name = "name", nullable = false, unique = true, length = 50)
    private String name;

}
