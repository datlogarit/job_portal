package com.project.jobportal.repositories;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.jobportal.models.Reports;

import java.util.List;

@Repository
public interface IReportRepository extends JpaRepository<Reports, Long> {
    long countByIsSolve(int isSolve);

    List<Reports> findAllByIsSolve(Integer statusSolve, Sort sort);
}