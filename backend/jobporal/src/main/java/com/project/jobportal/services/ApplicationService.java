package com.project.jobportal.services;

import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.models.*;
import com.project.jobportal.repositories.*;
import com.project.jobportal.response.ApplicationResponse;
import lombok.RequiredArgsConstructor;
import org.apache.catalina.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    private final IInviteRepository iInviteRepository;

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
        Jobs job = jobService.getJobById(newApplication.getJobId().getId());
        Notifications notifications = Notifications.builder()
                .title("New candidates have applied")
                .content("A new candidate has applied for your job " + "\"" + newApplication.getJobId().getTitle() + "\""
                        + " Check now")
                .jobRelated(job)
                .categoryNotification("apply")
                .build();
        iNotificationRepository.save(notifications);
        Users user = iUserRepository.findById(job.getPostedBy().getId()).orElseThrow(() -> new RuntimeException("User not found"));
        NotiUserKey notiUserKey = new NotiUserKey(notifications.getId(), job.getPostedBy().getId());
        NotiUsers notiUsers = NotiUsers
                .builder()
                .id(notiUserKey)
                .idNoti(notifications)
                .idUser(user)
                .isRead(0)
                .build();
        iNotiUserRepository.save(notiUsers);
    }

    public void updateStatusApplication(long id, ApplicationDTO applicationDTO) {
        Applications applications = iApplicationRepository.findById(id).orElseThrow(()
                -> new RuntimeException("Application not found"));
        applications.setStatusApply(applicationDTO.getStatusApply());
        if (applicationDTO.getStatusApply().equals("Approved")) {
            Notifications newNotification = Notifications.builder()
                    .title("There is a change in job status")
                    .content("Congratulations, your application for the job " + "\"" + applications.getJobId().getTitle() + "\""
                            + " has been accepted" +
                            ", the employer will contact you soon.")
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
        if (applicationDTO.getStatusApply().equals("Rejected")) {
            Notifications newNotification = Notifications.builder()
                    .title("There is a change in job status")
                    .content("Your application for the job: " + "\"" + applications.getJobId().getTitle() + "\"" + " has been rejected," +
                            " explore other jobs")
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
//        ApplicationResponse applicationResponse = new ApplicationResponse();

        Applications applications = iApplicationRepository.finByApplicantIdAndJobId(applicantId, jobId).orElseThrow(()
                -> new RuntimeException("Application not found"));
//        applicationResponse.applications = applications;
//        iInviteRepository.existsByJobIdAndApplicantId(applications.getJobId(), applications.getApplicantId());
        return applications;
    }

    @Override
    public List<Applications> getAllApplicationByApplicantId(long applicantId) {
        List<Applications> applications = iApplicationRepository.finByApplicantId(applicantId).orElseThrow(()
                -> new RuntimeException("Application not found"));
        return applications;
    }

    @Override
    public List<ApplicationResponse> getApplicationByJobId(long jobId) {
        List<Applications> applications = iApplicationRepository.findByJobId(jobId).orElseThrow(()
                -> new RuntimeException("Application not found"));
        List<ApplicationResponse> applicationResponses = new ArrayList<ApplicationResponse>();
        for (Applications application : applications) {
            ApplicationResponse applicationResponse = new ApplicationResponse();
            applicationResponse.applications = application;

            applicationResponse.is_invite = iInviteRepository.existsByJobIdAndApplicantId(
                    application.getJobId(),
                    application.getApplicantId());
            applicationResponses.add(applicationResponse);
        }
        return applicationResponses;
    }


}

