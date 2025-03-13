package com.project.jobportal.services;

import com.project.jobportal.DTOs.CategoryDTO;
import com.project.jobportal.models.Categories;
import com.project.jobportal.repositories.ICategoryRepository;
import lombok.RequiredArgsConstructor;
import org.openqa.selenium.NotFoundException;
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
        Categories existCategory = getCategoryById(id);
        existCategory.setName(categoryDTO.getName());
        ICategoryRepository.save(existCategory);
    }

    @Override
    public Categories getCategoryById(long id) {
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

    //những hàm bên dưới để fake data
    //----------------------------------------------------------------------//
    public Categories createCategoryByName(String name) {
        Categories categories = Categories.builder().name(name).build();
        ICategoryRepository.save(categories);
        return categories;

    }

    @Override
    public Categories finByNameCategory(String name) {//name o trang web cao duoc la Giao Duc, name tai db là Giao duc
        return ICategoryRepository.findByName(name).orElseGet(() -> createCategoryByName(name));
    }//khong phan biet chu hoa, chu thuong
    //----------------------------------------------------------------------------//
}
