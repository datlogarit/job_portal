package com.project.jobportal.services;

import com.project.jobportal.DTOs.User_ApplicantDTO;
import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Users;
import com.project.jobportal.repositories.IApplicantRepository;
import com.project.jobportal.repositories.IUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.Date;

@Service
@RequiredArgsConstructor
public class ApplicantService implements IApplicantService {
    private final IApplicantRepository iApplicantRepository;
    private final IUserRepository iUserRepository;

    @Override
    public void crateApplicant(User_ApplicantDTO userApplicantDTO) {

        if (iApplicantRepository.findByEmail(userApplicantDTO.getEmail()) != null) {
            throw new RuntimeException("Email đã đã được sử dụng");
        }
        Users newUser = Users.builder()
                .email(userApplicantDTO.getEmail())
                .password(userApplicantDTO.getPassword())
                .name(userApplicantDTO.getName())
                .dob(LocalDate.of(1, 1, 1))
                .role("applicant")
                .urlAvatar("5726568_avtUser.png")
                .isActive(1)
                .build();
        Applicants newApplicant = Applicants.builder()
                .userId(newUser)
                .resume("")
                .gender("")
                .workingTime("")
                .profession("")
                .desiredLocation("")
                .desiredPosition("")
                .workExperience("")
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
