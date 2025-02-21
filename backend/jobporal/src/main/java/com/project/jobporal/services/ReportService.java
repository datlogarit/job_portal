package com.project.jobporal.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.jobporal.DTOs.ReportDTO;
import com.project.jobporal.models.Reports;
import com.project.jobporal.repositories.IJobRepository;
import com.project.jobporal.repositories.IRecruiterRepository;
import com.project.jobporal.repositories.IReportRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReportService implements IReportService {
    private final IReportRepository iReportRepository;
    private final IRecruiterRepository iRecruiterRepository;
    private final JobService jobService;

    @Override
    public void createReport(ReportDTO reportDTO) {
        jobService.getJobById(reportDTO.getReportedJob());
        iRecruiterRepository.findById(reportDTO.getReporter())
                .orElseThrow(() -> new RuntimeException("reporter not found"));
        Reports reports = Reports.builder()
                .reportedJob(reportDTO.getReportedJob())
                .reporter(reportDTO.getReporter())
                .reason(reportDTO.getReason())
                .isSolve(reportDTO.getIsSolved())
                .build();
        iReportRepository.save(reports);
    }

    @Override
    public void updateReport(long id, ReportDTO reportDTO) {
        // TODO Auto-generated method stub
    }

    @Override
    public List<Reports> getAllReport() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public Reports getReportById(long id) {
        // TODO Auto-generated method stub
        return null;
    }

}
