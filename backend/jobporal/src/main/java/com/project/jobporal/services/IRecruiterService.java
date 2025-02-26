package com.project.jobporal.services;

import java.util.List;

import com.project.jobporal.DTOs.User_RecruiterDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import com.project.jobporal.DTOs.RecruiterDTO;
import com.project.jobporal.models.Recruiters;

public interface IRecruiterService {
    void createRecruiter(User_RecruiterDTO userRecruiterDTO);

    void updateRecruiter(long Id, User_RecruiterDTO userRecruiterDTO);

    void deleteRecruiter();

    Recruiters getRecruiter(long id);

    Page<Recruiters> getAllRecruiters(PageRequest pageRequest);
}
