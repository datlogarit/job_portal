package com.project.jobportal.services;

import com.project.jobportal.DTOs.CategoryDTO;
import com.project.jobportal.models.Categories;

import java.util.List;

public interface ICategoryService {
    void createCategory(CategoryDTO categoryDTO);

    void updateCategory(long id, CategoryDTO categoryDTO);

    Categories getCategoryById(long id);

    List<Categories> getAllCategory();

    void deleteCategory(long id);

    Categories finByNameCategory(String name);
}
