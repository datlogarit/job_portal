package com.project.jobportal.services;

import java.util.List;

import com.project.jobportal.DTOs.ReportDTO;
import com.project.jobportal.models.Reports;

public interface IReportService {
    void createReport(ReportDTO reportDTO);

    void updateReport(long id, ReportDTO reportDTO);

    List<Reports> getAllReport();

    Reports getReportById(long id);
}
