package com.project.jobportal.DTOs;

import jakarta.validation.constraints.NotEmpty;
import lombok.*;

@Data//bao gồm getter, setter, toString, Constructor ko tham số(requireArgumentConstructor)
@NoArgsConstructor
public class CategoryDTO {
    @NotEmpty(message = "category's name can't be empty")
    private String name;
}
