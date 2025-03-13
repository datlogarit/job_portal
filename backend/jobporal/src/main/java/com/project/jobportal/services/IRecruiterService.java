package com.project.jobportal.services;

import com.project.jobportal.DTOs.User_RecruiterDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import com.project.jobportal.models.Recruiters;

public interface IRecruiterService {
    void createRecruiter(User_RecruiterDTO userRecruiterDTO);

    void updateRecruiter(long Id, User_RecruiterDTO userRecruiterDTO);

    void deleteRecruiter();

    Recruiters getRecruiter(long id);

    Page<Recruiters> getAllRecruiters(PageRequest pageRequest);
}
