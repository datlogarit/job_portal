package com.project.jobportal;

import com.project.jobportal.components.AnotherClass;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class JobporalApplication {

    public static void main(String[] args) {
        SpringApplication.run(JobporalApplication.class, args);

    }

}