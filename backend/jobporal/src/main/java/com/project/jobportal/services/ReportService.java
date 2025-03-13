package com.project.jobportal.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.jobportal.DTOs.ReportDTO;
import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.models.Reports;
import com.project.jobportal.repositories.IApplicantRepository;
import com.project.jobportal.repositories.IReportRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReportService implements IReportService {
    private final IReportRepository iReportRepository;
    private final IApplicantRepository iApplicantRepository;
    private final JobService jobService;

    @Override
    public void createReport(ReportDTO reportDTO) {
        Jobs existJob = jobService.getJobById(reportDTO.getReportedJob());
        Applicants existApplicants = iApplicantRepository.findById(reportDTO.getReporter())
                .orElseThrow(() -> new RuntimeException("reporter not found"));
        Reports reports = Reports.builder()
                .reportedJob(existJob)
                .reporter(existApplicants)
                .reason(reportDTO.getReason())
                .isSolve(0)
                .build();
        iReportRepository.save(reports);
    }

    @Override
    public void updateReport(long id, ReportDTO reportDTO) {
        Reports existReport = getReportById(id);
        if (existReport == null) {
            throw new RuntimeException("Report not found");
        }
        // chỉ cho phép sửa trạng thái giải quyết - quyền của admin
        existReport.setIsSolve(reportDTO.getIsSolve());
        iReportRepository.save(existReport);
    }

    @Override
    public List<Reports> getAllReport() {
        return iReportRepository.findAll();
    }

    @Override
    public Reports getReportById(long id) {
        Reports existReport = iReportRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Report not found"));
        return existReport;
    }

}
