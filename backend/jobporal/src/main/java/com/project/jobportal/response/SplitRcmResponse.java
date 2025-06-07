package com.project.jobportal.response;

import com.project.jobportal.models.Jobs;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class SplitRcmResponse {
    private int numJobContentBased;
    private List<Jobs> jobListCb;
    private int numJobCollaborativeFiltering;
    private List<Jobs> jobsListCf;
}
