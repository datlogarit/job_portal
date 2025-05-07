package com.project.jobportal.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobportal.DTOs.JobDTO;
import com.project.jobportal.DTOs.RecommenInputDTO;
import com.project.jobportal.models.Categories;
import com.project.jobportal.models.Companies;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.models.Recruiters;
import com.project.jobportal.repositories.IJobRepository;
import com.project.jobportal.repositories.IRecruiterRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.util.*;

@Service
@RequiredArgsConstructor
public class JobService implements IJobService {
//    private final RestTemplate restTemplate = new RestTemplate();

    private final IJobRepository iJobRepository;
    private final IRecruiterRepository iRecruiterRepository;
    private final RecruiterService recruiterService;
    private final CategoryService iCategoryService;
    private final CompanyService companyService;

    @Override
    public void createJob(JobDTO jobDTO) {
        Recruiters existRecruiter = iRecruiterRepository.findById(jobDTO.getPostedBy()).orElseThrow(()
                -> new RuntimeException("Recruiter not found"));

        Categories existCategory = iCategoryService.getCategoryById(jobDTO.getCategoryId());
        if (existCategory == null) {
            throw new RuntimeException("Category not found");
        }

        Jobs jobs = Jobs.builder()
                .title(jobDTO.getTitle())
                .minSalary(jobDTO.getMinSalary())
                .maxSalary(jobDTO.getMaxSalary())
                .experience(jobDTO.getExperience())
                .workingTime(jobDTO.getWorkingTime())
                .numberRecruitment(jobDTO.getNumberRecruitment())
                .gender(jobDTO.getGender())
                .position(jobDTO.getPosition())
                .expDate(jobDTO.getExpDate())
                .requirement(jobDTO.getRequirement())
                .description(jobDTO.getDescription())
                .benefit(jobDTO.getBenefit())
                .workLocation(jobDTO.getWorkLocation())
                .postedBy(existRecruiter)
                .categoryId(existCategory)
                .status(jobDTO.getStatus())
                .isEdit(jobDTO.getIsEdit())
                .isLock(jobDTO.getIsLock())
                .isActive(jobDTO.getIsActive())
                .build();
        iJobRepository.save(jobs);
    }

    @Override
    public void createVirtualData(String title, String experience, String workingTime,
                                  int numberRecruitment, String gender, String position,
                                  LocalDate exp_date, String requirement, String description,
                                  String benefit, String workLocation, String category,
                                  int minSalary, int maxSalary,
                                  String companyName, String ImgCpnUrl, String introduction,
                                  String location, String email, String name, String password) {

        Categories categories = iCategoryService.finByNameCategory(category);
        Companies companies = companyService.finByName(companyName, location, ImgCpnUrl);
        //search company by name. neu cong ty ton tai => lay cong ty do, sau do lay recruiter tuong ung
        //neu cong ty do khong ton tai => tao cong ty moi, tao recruiter tuong ung
        Recruiters recruiters = iRecruiterRepository.finRecruiterByCompanyId(companies.getId())
                .orElseGet(() -> recruiterService.createRecruiterFake(email, password, name, companies.getId()));
        Jobs newJob = Jobs.builder()
                .title(title)
                .minSalary(minSalary)
                .maxSalary(maxSalary)
                .experience(experience)
                .workingTime(workingTime)
                .numberRecruitment(numberRecruitment)
                .gender(gender)
                .position(position)
                .expDate(exp_date)
                .requirement(requirement)
                .description(description)
                .benefit(benefit)
                .workLocation(workLocation)
                .postedBy(recruiters)
                .categoryId(categories)
                .status("open")
                .isEdit(0)
                .isLock(0)//khoa tu phia nguoi dung
                .isActive(0)//khóa tu phia admin
                .build();
        iJobRepository.save(newJob);
    }

    @Override
    public void updateJob(long id, JobDTO jobDTO) {
        Jobs existJob = iJobRepository.findById(id).orElseThrow(() -> new RuntimeException("Job not found"));
        existJob.setTitle(jobDTO.getTitle());
        existJob.setMinSalary(jobDTO.getMinSalary());
        existJob.setMaxSalary(jobDTO.getMaxSalary());
        existJob.setExperience(jobDTO.getExperience());
        existJob.setWorkingTime(jobDTO.getWorkingTime());
        existJob.setNumberRecruitment(jobDTO.getNumberRecruitment());
        existJob.setGender(jobDTO.getGender());
        existJob.setPosition(jobDTO.getPosition());
        existJob.setExpDate(jobDTO.getExpDate());
        existJob.setRequirement(jobDTO.getRequirement());
        existJob.setDescription(jobDTO.getDescription());
        existJob.setBenefit(jobDTO.getBenefit());
        existJob.setWorkLocation(jobDTO.getWorkLocation());
        existJob.setPostedBy(iRecruiterRepository.findById(jobDTO.getPostedBy()).get());
        existJob.setCategoryId(iCategoryService.getCategoryById(jobDTO.getCategoryId()));
        existJob.setStatus(jobDTO.getStatus());
        existJob.setIsEdit(jobDTO.getIsEdit());
        existJob.setIsLock(jobDTO.getIsLock());
        existJob.setIsActive(jobDTO.getIsActive());
        iJobRepository.save(existJob);
    }

    @Override
    public Jobs getJobById(long id) {
        return iJobRepository.findById(id).orElseThrow(() -> new RuntimeException("Job not found"));
    }

    @Override
    public Page<Jobs> getAllJob(PageRequest pageRequest) {
        return iJobRepository.findAll(pageRequest);
    }

    @Override
    public Page<Jobs> searchJob(String SearchKeyword, PageRequest pageRequest) {
        return iJobRepository.searchJob(SearchKeyword, pageRequest);
    }

    @Override
    public Page<Jobs> searchJobByCategory(Long categoryId, PageRequest pageRequest) {
        Categories newCategory = new Categories();
        newCategory.setId(categoryId);

        return iJobRepository.findByCategoryId(newCategory, pageRequest);
    }

    @Override
    public Page<Jobs> searchJobByCompany(long companyId, PageRequest pageRequest) {
        return iJobRepository.findJobsByCompanyId(companyId, pageRequest);
    }

    @Override
    public Page<Jobs> searchJobByFilter(String category, String position, String experience, Integer minSalary,
                                        Integer maxSalary, PageRequest pageRequest) {
        Page<Jobs> jobs = iJobRepository.filterJobs(category, position, experience, minSalary, maxSalary, pageRequest);
        return jobs;
    }

    @Override
    public List<Jobs> searchSameJobById(long jobId) throws Exception {
        RestTemplate restTemplate1 = new RestTemplate();
        List<Jobs> sameJobs = new ArrayList<>();
        String url = String.format("http://localhost:8000/api/v1/recommend/%d", jobId);

        ResponseEntity<String> response = restTemplate1.getForEntity(url, String.class);

        ObjectMapper mapper = new ObjectMapper();
        //tạo ra 1 node json
        JsonNode root = mapper.readTree(response.getBody()); // jsonString là chuỗi JSON
        JsonNode jobs = root.get("jobs");//lấy ra node jobs
        for (JsonNode job : jobs) {
            long id = job.get("id").asInt();//lấy ra node id trong json
            sameJobs.add(getJobById(id));
        }
        return sameJobs;
    }

    @Override
    public List<Jobs> getRecommendedJob(RecommenInputDTO recommenInputDTO) throws Exception {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8000/api/v1/hybrid_recommend_jobs";

        // Chuẩn bị JSON body
//        Map<String, Object> body = new HashMap<>();
//        body.put("user_id", inputDTO.getUserId());
//        body.put("title", inputDTO.getTitle());
//        body.put("category_id", inputDTO.getCategoryId());
//        body.put("locations", List.of(inputDTO.getWorkLocation()));
//        body.put("total_jobs", inputDTO.getTotalJobs());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<RecommenInputDTO> requestEntity = new HttpEntity<>(recommenInputDTO, headers);

        // Gọi Python API
        ResponseEntity<String> response = restTemplate.postForEntity(url, requestEntity, String.class);

        // Xử lý JSON trả về
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(response.getBody());
        JsonNode cbJobs = root.get("content_based_jobs");
        JsonNode cfJobs = root.get("collaborative_filtering_jobs");

        List<Jobs> recommended = new ArrayList<>();
        for (JsonNode job : cbJobs) {
            long id = job.asLong();
            recommended.add(getJobById(id)); // hàm tự viết lấy từ DB
        }
        for (JsonNode job : cfJobs) {
            long id = job.asLong();
            recommended.add(getJobById(id));
        }

        return recommended;
    }
}
