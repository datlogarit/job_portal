package com.project.jobporal.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.jobporal.DTOs.ReportDTO;
import com.project.jobporal.models.Applicants;
import com.project.jobporal.models.Jobs;
import com.project.jobporal.models.Reports;
import com.project.jobporal.repositories.IApplicantRepository;
import com.project.jobporal.repositories.IReportRepository;

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
