//package com.project.jobportal;
//
//import com.project.jobportal.services.UserService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.stereotype.Component;
//
//@RequiredArgsConstructor
//@Component
//public class StartupRunner implements CommandLineRunner {
//    private final UserService userService;
//
//    @Override
//    public void run(String... args) {
//        System.out.println("===> StartupRunner đang chạy...");
//        userService.migratePasswordsToBCrypt();
//    }
//}