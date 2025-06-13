package com.project.jobportal.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobportal.DTOs.User_ApplicantDTO;
import com.project.jobportal.models.Applicants;
import com.project.jobportal.models.Categories;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.models.Users;
import com.project.jobportal.repositories.IApplicantRepository;
import com.project.jobportal.repositories.ICategoryRepository;
import com.project.jobportal.repositories.IInviteRepository;
import com.project.jobportal.repositories.IUserRepository;
import com.project.jobportal.response.RecommendApplicantResponse;
import com.project.jobportal.security.PasswordUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ApplicantService implements IApplicantService {
    private final IApplicantRepository iApplicantRepository;
    private final IUserRepository iUserRepository;
    private final IInviteRepository iInviteRepository;
    private final IJobService iJobService;
    private final ICategoryRepository iCategoryRepository;

    @Override
    public Applicants login(String email, String password) {
        Applicants applicants = iApplicantRepository.findByEmail(email);
        if (applicants == null || !PasswordUtil.matchPassword(password, applicants.getUserId().getPassword())) {
            throw new RuntimeException("Email or password not match");
        }
        if (applicants.getUserId().getIsActive() == 0) {
            throw new RuntimeException("This account has been locked");
        }
        return applicants;
    }

    @Override
    public void crateApplicant(User_ApplicantDTO userApplicantDTO) {
        String hashedPassword = PasswordUtil.hashPassword(userApplicantDTO.getPassword());
        if (iApplicantRepository.findByEmail(userApplicantDTO.getEmail()) != null) {
            throw new RuntimeException("Email already exists");
        }
//        Categories categories = iCategoryRepository.findById(userApplicantDTO.getField()).orElseThrow(()
//                -> new RuntimeException("Category not found"));
        Users newUser = Users.builder()
                .email(userApplicantDTO.getEmail())
                .password(hashedPassword)
                .name(userApplicantDTO.getName())
                .dob(LocalDate.of(1, 1, 1))
                .role("applicant")
                .urlAvatar("default-avatar-profile-icon-vector-social-media-user-photo-700-205577532.jpg")
                .isActive(1)
                .build();
        Applicants newApplicant = Applicants.builder()
                .userId(newUser)
                .resume("")
                .gender("")
                .workingTime("")
//                .field(categories)
                .desiredLocation("")
                .desiredPosition("")
                .workExperience("")
//                .skills("","")
                .build();
        iApplicantRepository.save(newApplicant);
    }

    @Override
    public Applicants updateApplicant(long id, User_ApplicantDTO applicantDTO) {
        Users existUser = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("applicant not found"));

        if (applicantDTO.getPassword() != null && !applicantDTO.getPassword().isEmpty()) {
            existUser.setPassword(applicantDTO.getPassword());
        }
        if (applicantDTO.getName() != null && !applicantDTO.getName().isEmpty()) {
            existUser.setName(applicantDTO.getName());
        }
        if (applicantDTO.getPhoneNumber() != null && !applicantDTO.getPhoneNumber().isEmpty()) {
            existUser.setPhoneNumber(applicantDTO.getPhoneNumber());
        }
        if (applicantDTO.getDob() != null) {
            existUser.setDob(applicantDTO.getDob());
        }
        iUserRepository.save(existUser);
//        existUser.setUrlAvatar(applicantDTO.getUrlAvatar());
        Applicants existApplicant = getApplicantById(id);

        existApplicant.setUserId(existUser);
//        existApplicant.setResume(applicantDTO.getResume());
        if (applicantDTO.getGender() != null && !applicantDTO.getGender().isEmpty()) {
            existApplicant.setGender(applicantDTO.getGender());
        }
        if (applicantDTO.getWorkingTime() != null && !applicantDTO.getWorkingTime().isEmpty()) {
            existApplicant.setWorkingTime(applicantDTO.getWorkingTime());
        }

        if (applicantDTO.getField() != null) {
            Categories categories = iCategoryRepository.findById(applicantDTO.getField()).orElseThrow(()
                    -> new RuntimeException("Category not found"));
            existApplicant.setField(categories);
        }

        if (applicantDTO.getDesiredLocation() != null && !applicantDTO.getDesiredLocation().isEmpty()) {
            existApplicant.setDesiredLocation(applicantDTO.getDesiredLocation());
        }

        if (applicantDTO.getDesiredPosition() != null && !applicantDTO.getDesiredPosition().isEmpty()) {
            existApplicant.setDesiredPosition(applicantDTO.getDesiredPosition());
        }

        if (applicantDTO.getCurrentPosition() != null && !applicantDTO.getCurrentPosition().isEmpty()) {
            existApplicant.setCurrentPosition(applicantDTO.getCurrentPosition());
        }

        if (applicantDTO.getWorkExperience() != null && !applicantDTO.getWorkExperience().isEmpty()) {
            existApplicant.setWorkExperience(applicantDTO.getWorkExperience());
        }
        if (applicantDTO.getSkills() != null && !applicantDTO.getSkills().isEmpty()) {
            existApplicant.setSkills(applicantDTO.getSkills());
        }

        iApplicantRepository.save(existApplicant);
        return existApplicant;
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
    public List<RecommendApplicantResponse> recommendApplicantByJobId(long jobId) throws Exception {
        Jobs jobs = iJobService.getJobById(jobId);
        RestTemplate restTemplate1 = new RestTemplate();
        List<RecommendApplicantResponse> recommendedApplicant = new ArrayList<>();
        String url = String.format("http://localhost:8000/api/v1/recommendApplicant/%d", jobId);

        ResponseEntity<String> response = restTemplate1.getForEntity(url, String.class);

        ObjectMapper mapper = new ObjectMapper();
        //tạo ra 1 node json
        JsonNode root = mapper.readTree(response.getBody()); // jsonString là chuỗi JSON
        JsonNode applicants = root.get("applicants");
        for (JsonNode applicant : applicants) {
            RecommendApplicantResponse responseObj = new RecommendApplicantResponse();
            long applicant_id = applicant.get("user_id").asInt();
            Applicants applicants1 = getApplicantById(applicant_id);
            responseObj.setApplicant(applicants1);
            //kiem tra xem voi applicant nay va job duoc truyen vao thi co ban ghi invite hay khong
            //neu co thi truong statusInvite gan gia tri true, neu khong gan gia tri false
            if (iInviteRepository.existsByJobIdAndApplicantId(jobs, applicants1)) {
                responseObj.setStatusInvite(true);
            } else {
                responseObj.setStatusInvite(false);
            }
            ;
            recommendedApplicant.add(responseObj);
        }
        return recommendedApplicant;
    }
//            recommendedApplicant.add((getApplicantById(applicant_id)));

    @Override
    public Page<Applicants> getAllApplicant(PageRequest pageRequest) {
        return iApplicantRepository.findAll(pageRequest);
    }

    @Override
    public long countTotalApplicant() {
        return iApplicantRepository.count();
    }

}
