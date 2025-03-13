package com.project.jobportal.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.jobportal.models.Reports;

@Repository
public interface IReportRepository extends JpaRepository<Reports, Long> {

}