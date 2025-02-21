package com.project.jobporal.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.jobporal.models.Reports;

@Repository
public interface IReportRepository extends JpaRepository<Reports, Long> {

}