package com.project.jobporal.services;

import com.project.jobporal.DTOs.User_ApplicantDTO;
import com.project.jobporal.models.Applicants;
import com.project.jobporal.models.Users;
import com.project.jobporal.repositories.IApplicantRepository;
import com.project.jobporal.repositories.IUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
@RequiredArgsConstructor
public class ApplicantService implements IApplicantService {
    private final IApplicantRepository iApplicantRepository;
    private final IUserRepository iUserRepository;

    @Override
    public void crateApplicant(User_ApplicantDTO userApplicantDTO) {
        Users newUser = Users.builder()
                .email(userApplicantDTO.getEmail())
                .password(userApplicantDTO.getPassword())
                .name(userApplicantDTO.getName())
                .phoneNumber(userApplicantDTO.getPhoneNumber())
                .dob(userApplicantDTO.getDob())
                .role("applicant")
                .urlAvatar("5726568_avtUser.png")
                .isActive(userApplicantDTO.getIsActive())
                .build();
        Applicants newApplicant = Applicants.builder()
                .userId(newUser)
                .resume(userApplicantDTO.getResume())
                .gender(userApplicantDTO.getGender())
                .workingTime(userApplicantDTO.getWorkingTime())
                .profession(userApplicantDTO.getProfession())
                .desiredLocation(userApplicantDTO.getDesiredLocation())
                .desiredPosition(userApplicantDTO.getDesiredPosition())
                .workExperience(userApplicantDTO.getWorkExperience())
                .build();
        iApplicantRepository.save(newApplicant);
    }

    @Override
    public void updateApplicant(long id, User_ApplicantDTO applicantDTO) {
        Users existUser = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));
        existUser.setPassword(applicantDTO.getPassword());
        existUser.setName(applicantDTO.getName());
        existUser.setPhoneNumber(applicantDTO.getPhoneNumber());
        existUser.setDob(applicantDTO.getDob());
        existUser.setUrlAvatar(applicantDTO.getUrlAvatar());
        Applicants existApplicant = getApplicantById(id);
        existApplicant.setUserId(existUser);
        existApplicant.setResume(applicantDTO.getResume());
        existApplicant.setGender(applicantDTO.getGender());
        existApplicant.setWorkingTime(applicantDTO.getWorkingTime());
        existApplicant.setProfession(applicantDTO.getProfession());
        existApplicant.setDesiredLocation(applicantDTO.getDesiredLocation());
        existApplicant.setDesiredPosition(applicantDTO.getDesiredPosition());
        existApplicant.setWorkExperience(applicantDTO.getWorkExperience());
        iApplicantRepository.save(existApplicant);
    }

    public void uploadResume(long applicantId, String fileName) throws IOException {
        Applicants existApplicant = getApplicantById(applicantId);

        String oldFile = existApplicant.getResume();
        //duong dan tuong doi den file (relative path of file)
        Path oldPath = Paths.get("resumeApplicant", oldFile);

        existApplicant.setResume(fileName);
        Files.delete(oldPath);
        iApplicantRepository.save(existApplicant);

    }

    @Override
    public Applicants getApplicantById(long id) {
        return iApplicantRepository.findById(id).orElseThrow(() -> new RuntimeException("applicant not found"));
    }

    @Override
    public Page<Applicants> getAllApplicant(PageRequest pageRequest) {
        return iApplicantRepository.findAll(pageRequest);
    }
}
