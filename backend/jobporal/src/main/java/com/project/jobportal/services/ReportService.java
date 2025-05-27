package com.project.jobportal.services;

import java.util.List;

import org.springframework.data.domain.Sort;
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
    private final UserService userService;

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
    public void updateStatusReport(long id, long statusSolve) {
        Reports existReport = getReportById(id);
        if (existReport == null) {
            throw new RuntimeException("Report not found");
        }
        // chỉ cho phép sửa trạng thái giải quyết - quyền của admin
        existReport.setIsSolve(statusSolve);
        iReportRepository.save(existReport);
    }

    @Override
    public List<Reports> getAllReport() {
        return iReportRepository.findAllByIsSolve(0, Sort.by(Sort.Direction.DESC, "createdAt"));
    }

    @Override
    public Reports getReportById(long id) {
        Reports existReport = iReportRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Report not found"));
        return existReport;
    }

    @Override
    public void banUser(Long reportId) {
        Reports reports = iReportRepository.findById(reportId).orElseThrow(
                () -> new RuntimeException("not foud"));
        userService.updateStatusUser(reports.getReportedJob().getPostedBy().getId(), 0);//ban user
        updateStatusReport(reportId, 1);//update status
    }

    public void banPost(Long reportId) {
        Reports reports = iReportRepository.findById(reportId).orElseThrow(
                () -> new RuntimeException("not foud"));
        jobService.updateLockJob(reports.getReportedJob().getId(), 1);//ban job
        updateStatusReport(reportId, 1);//update status
    }


}
