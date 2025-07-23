package com.project.jobportal.components;

import com.project.jobportal.services.ApplicantService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@RequiredArgsConstructor
public class AnotherClass {
    private final ApplicantService applicantService;

    public void getApplicantService() {
        applicantService.testInjection();
    }
}
