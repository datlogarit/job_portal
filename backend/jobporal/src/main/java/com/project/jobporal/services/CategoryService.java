package com.project.jobporal.services;


import com.project.jobporal.DTOs.CategoryDTO;
import com.project.jobporal.models.Categories;
import com.project.jobporal.repositories.ICategoryRepository;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

//cac service trong spring boot co ta dung tach biet logic
// - phan repo se tuong tac voi db (crud) (lay danh sach nguoi dung)
// - phan service se dung phan phan repo de thuc hien cac logic, tinh toan truoc khi tra ve cho controller
// (lay ds nguoi dung va tien hanh loc,...)
//@AllArgsConstructor
@RequiredArgsConstructor
@Service
public class CategoryService implements ICategoryService {
    private final ICategoryRepository ICategoryRepository;

    @Override
    public void createCategory(CategoryDTO categoryDTO) {
        Categories categories = Categories.builder().name(categoryDTO.getName()).build();
        ICategoryRepository.save(categories);
    }

    @Override
    public void updateCategory(long id, CategoryDTO categoryDTO) {
        Categories existCategory = getCategoryByID(id);
        existCategory.setName(categoryDTO.getName());
        ICategoryRepository.save(existCategory);
    }

    @Override
    public Categories getCategoryByID(long id) {
        return ICategoryRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Category not found"));
    }


    @Override
    public List<Categories> getAllCategory() {
        return ICategoryRepository.findAll();
    }

    @Override
    public void deleteCategory(long id) {
        ICategoryRepository.deleteById(id);
    }
}
