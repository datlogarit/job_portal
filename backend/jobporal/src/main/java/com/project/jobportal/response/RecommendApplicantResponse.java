package com.project.jobportal.response;

import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Users;
import lombok.Data;

@Data
public class RecommendApplicantResponse {

    private Applicants applicant;

    private boolean statusInvite;
}
