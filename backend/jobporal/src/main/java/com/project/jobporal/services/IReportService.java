package com.project.jobporal.services;

import java.util.List;

import com.project.jobporal.DTOs.ReportDTO;
import com.project.jobporal.models.Reports;

public interface IReportService {
    void createReport(ReportDTO reportDTO);

    void updateReport(long id, ReportDTO reportDTO);

    List<Reports> getAllReport();

    Reports getReportById(long id);
}
