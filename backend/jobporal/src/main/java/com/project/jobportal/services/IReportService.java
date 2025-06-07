package com.project.jobportal.services;

import java.util.List;

import com.project.jobportal.DTOs.ReportDTO;
import com.project.jobportal.models.Reports;

public interface IReportService {
    void createReport(ReportDTO reportDTO);

    void updateStatusReport(long id, long statusSolve);

    List<Reports> getAllReport();

    Reports getReportById(long id);

    void banUser(Long reportId);

    long countTotalReportPending();
}
