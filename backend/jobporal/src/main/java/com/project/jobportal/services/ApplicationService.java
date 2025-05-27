package com.project.jobportal.services;

import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.models.*;
import com.project.jobportal.repositories.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ApplicationService implements IApplicationService {
    private final IApplicationRepository iApplicationRepository;
    private final INotificationRepository iNotificationRepository;
    private final INotiUserRepository iNotiUserRepository;
    private final IUserRepository iUserRepository;
    private final ApplicantService applicantService;
    private final JobService jobService;

    @Override
    public void createApplication(ApplicationDTO applicationDTO, String fileName) {
        Applicants applicants = applicantService.getApplicantById(applicationDTO.getApplicantId());
        Jobs jobs = jobService.getJobById(applicationDTO.getJobId());
        Applications newApplication = Applications.builder()
                .applicantId(applicants)
                .jobId(jobs)
                .statusApply(applicationDTO.getStatusApply())
                .fullName(applicationDTO.getFullName())
                .email(applicationDTO.getEmail())
                .phoneNumber(applicationDTO.getPhoneNumber())
                .cvUrl(fileName)
                .message(applicationDTO.getMessage())
                .build();
        iApplicationRepository.save(newApplication);
    }

    public void updateStatusApplication(long id, ApplicationDTO applicationDTO) {
        Applications applications = iApplicationRepository.findById(id).orElseThrow(()
                -> new RuntimeException("Application not found"));
        applications.setStatusApply(applicationDTO.getStatusApply());
        if (applicationDTO.getStatusApply().equals("approved")) {
            Notifications newNotification = Notifications.builder()
                    .title("Có sự thay đổi trạng thái công việc")
                    .content("Xin chúc mừng, đơn ứng tuyển vào công việc " + applications.getJobId().getTitle() + "đã được chấp nhận, nhà tuyển dụng sẽ sớm liên hệ với bạn để trao đổi những bước tiếp theo")
                    .jobRelated(applications.getJobId())
                    .categoryNotification("status change")
                    .build();
            iNotificationRepository.save(newNotification);
            Users users = iUserRepository.findById(applications.getApplicantId().getId()).orElseThrow(() ->
                    new RuntimeException("user not found"));
            NotiUserKey notiUserKey = new NotiUserKey(newNotification.getId(), users.getId());

            NotiUsers notiUsers = NotiUsers.builder()
                    .id(notiUserKey)
                    .idNoti(newNotification)
                    .idUser(users)
                    .isRead(0)
                    .build();
            iNotiUserRepository.save(notiUsers);
        }
        if (applicationDTO.getStatusApply().equals("rejected")) {
            Notifications newNotification = Notifications.builder()
                    .title("Có sự thay đổi trạng thái công việc")
                    .content("Đơn ứng tuyển vào công việc " + applications.getJobId().getTitle() + "đã bị từ chối, hãy khám phá thêm các công việc phù hợp nhé")
                    .jobRelated(applications.getJobId())
                    .categoryNotification("status change")
                    .build();
            iNotificationRepository.save(newNotification);
            Users users = iUserRepository.findById(applications.getApplicantId().getId()).orElseThrow(() ->
                    new RuntimeException("user not found"));
            NotiUserKey notiUserKey = new NotiUserKey(applications.getId(), users.getId());

            NotiUsers notiUsers = NotiUsers.builder()
                    .id(notiUserKey)
                    .idNoti(newNotification)
                    .idUser(users)
                    .isRead(0)
                    .build();
            iNotiUserRepository.save(notiUsers);
        }
        iApplicationRepository.save(applications);
    }

    @Override
    public Applications getApplicationByApplicantIdAndJobId(long applicantId, long jobId) {
        Applications applications = iApplicationRepository.finByApplicantIdAndJobId(applicantId, jobId).orElseThrow(()
                -> new RuntimeException("Application not found"));
        return applications;
    }

    @Override
    public List<Applications> getAllApplicationByApplicantId(long applicantId) {
        List<Applications> applications = iApplicationRepository.finByApplicantId(applicantId).orElseThrow(()
                -> new RuntimeException("Application not found"));
        return applications;
    }

    @Override
    public List<Applications> getApplicationByJobId(long jobId) {
        List<Applications> applications = iApplicationRepository.findByJobId(jobId).orElseThrow(()
                -> new RuntimeException("Application not found"));
        return applications;
    }


}

