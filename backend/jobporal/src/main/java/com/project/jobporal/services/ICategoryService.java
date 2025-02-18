package com.project.jobporal.services;

import com.project.jobporal.DTOs.CategoryDTO;
import com.project.jobporal.models.Categories;

import java.util.List;

public interface ICategoryService {
    void createCategory(CategoryDTO categoryDTO);

    void updateCategory(long id, CategoryDTO categoryDTO);

    Categories getCategoryByID(long id);

    List<Categories> getAllCategory();

    void deleteCategory(long id);
}
