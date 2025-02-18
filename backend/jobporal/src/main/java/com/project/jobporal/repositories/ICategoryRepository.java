package com.project.jobporal.repositories;

import com.project.jobporal.models.Categories;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

//giao tiep voi db thong qua spring data JPA - cung cap san cac phuong thuc CRUD
@Repository
public interface ICategoryRepository extends JpaRepository<Categories, Long> {
}
