package com.project.jobporal.repositories;

import com.project.jobporal.models.Jobs;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


//tìm kiếm theo title
public interface IJobReposiroty extends JpaRepository<Jobs, Long> {
    @Query("SELECT j FROM Jobs j WHERE LOWER(j.title) LIKE LOWER(CONCAT('%', :title, '%'))")
    List<Jobs> searchJob(@Param("title") String title);
}