package com.project.jobportal.repositories;

import com.project.jobportal.models.Categories;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

//giao tiep voi db thong qua spring data JPA - cung cap san cac phuong thuc CRUD
@Repository
public interface ICategoryRepository extends JpaRepository<Categories, Long> {
    Optional<Categories> findByName(String name);//ko phan biet chu hoa, chu thuong
}
