package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.CategoryDTO;
import com.project.jobporal.services.CategoryService;
import jakarta.validation.Valid;
import lombok.Data;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController// dung de danh dau class java nhu mot REST API Controller
@RequestMapping("api/v1/category")//danh dau duong dan chung cho tat ca cac API trong class
@Data//thay the getter, setter, requireArgumentConstructor, toString
public class CategoryController {
    private final CategoryService categoryService;


    @PostMapping("")
    //Nếu tham số truyền vào là 1 object thì sao ? => Data Transfer Object = Request Object
    public ResponseEntity<?> createCategory(
            @RequestBody @Valid CategoryDTO categoryDTO, BindingResult result) {
        //if expression have bug, it will store error instead of through exception
        if (result.hasErrors()) {
            List<String> listErr = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(listErr);
        }
        categoryService.createCategory(categoryDTO);
        return ResponseEntity.ok("Insert category successfully");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> putCategoty(@PathVariable long id, @RequestBody CategoryDTO categoryDTO) {
        // lay gtri tu url path va gan no vao tham so cua ham
        categoryService.updateCategory(id, categoryDTO);
        return ResponseEntity.ok("this is put category with id = " + id);
    }

    @GetMapping("/{id}")
    //danh dau duong dan API getAllCatatory
    public ResponseEntity<?> getCategoryById(@PathVariable long id) {
        return ResponseEntity.ok(categoryService.getCategoryByID(id));
    }

    @GetMapping("")
    //danh dau duong dan API getAllCatatory
    public ResponseEntity<?> getAllCategory() {
        return ResponseEntity.ok(categoryService.getAllCategory());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteCategory(@PathVariable long id) {
        categoryService.deleteCategory(id);
        return ResponseEntity.ok("delete category successfully");
    }
}
