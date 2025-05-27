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
        return iApplicantRepository.login(email, password);
    }

    @Override
    public void crateApplicant(User_ApplicantDTO userApplicantDTO) {

        if (iApplicantRepository.findByEmail(userApplicantDTO.getEmail()) != null) {
            throw new RuntimeException("Email đã đã được sử dụng");
        }
        Categories categories = iCategoryRepository.findById(userApplicantDTO.getField()).orElseThrow(()
                -> new RuntimeException("Category not found"));
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
                .field(categories)
                .desiredLocation("")
                .desiredPosition("")
                .workExperience("")
                .build();
        iApplicantRepository.save(newApplicant);
    }

    @Override
    public void updateApplicant(long id, User_ApplicantDTO applicantDTO) {
        Users existUser = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));
        Categories categories = iCategoryRepository.findById(applicantDTO.getField()).orElseThrow(()
                -> new RuntimeException("Category not found"));
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
        existApplicant.setField(categories);
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
    public List<RecommendApplicantResponse> recommendApplicantByJobId(long jobId) throws Exception {
        Jobs jobs = iJobService.getJobById(jobId);
        RestTemplate restTemplate1 = new RestTemplate();
        List<RecommendApplicantResponse> recommendedApplicant = new ArrayList<>();
        String url = String.format("http://localhost:8000/api/v1/recommendApplicant/%d", jobId);

        ResponseEntity<String> response = restTemplate1.getForEntity(url, String.class);

        ObjectMapper mapper = new ObjectMapper();
        //tạo ra 1 node json
        JsonNode root = mapper.readTree(response.getBody()); // jsonString là chuỗi JSON
        JsonNode applicants = root.get("applicants");//lấy ra node jobs
        for (JsonNode applicant : applicants) {
            RecommendApplicantResponse responseObj = new RecommendApplicantResponse();
            long applicant_id = applicant.get("user_id").asInt();//lấy ra node id trong json
//            từ ds các userId trên, mình tiep tục tìm các user do trong bang invite voi jobId tuong ung
            //neu co ban ghi, gan them truong invite la true, neu k co, gan them truong invite la false
            // va tra kq cho frontend
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
}
