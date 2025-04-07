//package com.project.jobportal.utilities;
//
//import com.project.jobportal.services.NotificationService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.stereotype.Component;
//
//@Component
////@RequiredArgsConstructor
//public class StartupRunner implements CommandLineRunner {
//
//    private final NotificationService notificationService;
//
//    // Inject NotificationService vào constructor
//    public StartupRunner(NotificationService notificationService) {
//        this.notificationService = notificationService;
//    }
//
//    @Override
//    public void run(String... args) {
//        System.out.println(">>> Checking for expiring jobs...");
//        notificationService.notifyExpiringJobs();
//        System.out.println(">>> Done checking.");
//    }
//}
