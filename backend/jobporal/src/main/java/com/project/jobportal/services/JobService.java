package com.project.jobportal.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobportal.DTOs.JobDTO;
import com.project.jobportal.DTOs.RecommenInputDTO;
import com.project.jobportal.models.*;
import com.project.jobportal.repositories.IJobRepository;
import com.project.jobportal.repositories.IRecruiterRepository;

import com.project.jobportal.response.SplitRcmResponse;
import lombok.RequiredArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.*;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
                .status("Opening")// Khóa từ phía ngươi dùng
                .isLock(0)//khóa từ phía admin
                .requiredSkill(jobDTO.getRequiredSkill())
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
//                .isEdit(0)
                .isLock(0)//khoa tu phia nguoi dung
//                .isActive(0)//khóa tu phia admin
                .build();
        iJobRepository.save(newJob);
    }

    @Override
    public void updateJob(long id, JobDTO jobDTO) {
        Jobs existJob = iJobRepository.findById(id).orElseThrow(() -> new RuntimeException("Job not found"));
        if (jobDTO.getTitle() != null) {
            existJob.setTitle(jobDTO.getTitle());
        }
        if (jobDTO.getMinSalary() != null) {
            existJob.setMinSalary(jobDTO.getMinSalary());
        }
        if (jobDTO.getMaxSalary() != null) {
            existJob.setMaxSalary(jobDTO.getMaxSalary());
        }
        if (jobDTO.getExperience() != null) {
            existJob.setExperience(jobDTO.getExperience());
        }
        if (jobDTO.getWorkingTime() != null) {
            existJob.setWorkingTime(jobDTO.getWorkingTime());
        }
        if (jobDTO.getNumberRecruitment() != null) {
            existJob.setNumberRecruitment(jobDTO.getNumberRecruitment());
        }
        if (jobDTO.getGender() != null) {
            existJob.setGender(jobDTO.getGender());
        }
        if (jobDTO.getPosition() != null) {
            existJob.setPosition(jobDTO.getPosition());
        }
        if (jobDTO.getExpDate() != null) {
            existJob.setExpDate(jobDTO.getExpDate());
        }
        if (jobDTO.getRequirement() != null) {
            existJob.setRequirement(jobDTO.getRequirement());
        }
        if (jobDTO.getDescription() != null) {
            existJob.setDescription(jobDTO.getDescription());
        }
        if (jobDTO.getBenefit() != null) {
            existJob.setBenefit(jobDTO.getBenefit());
        }
        if (jobDTO.getWorkLocation() != null) {
            existJob.setWorkLocation(jobDTO.getWorkLocation());
        }
        if (jobDTO.getPostedBy() != null) {
            existJob.setPostedBy(iRecruiterRepository.findById(jobDTO.getPostedBy()).get());
        }
        if (jobDTO.getCategoryId() != null) {
            existJob.setCategoryId(iCategoryService.getCategoryById(jobDTO.getCategoryId()));
        }
        if (jobDTO.getStatus() != null) {
            existJob.setStatus(jobDTO.getStatus());
        }
//        if (jobDTO.getIsEdit(
//            existJob.setIsEdit(jobDTO.getIsEdit());
//        }
        if (jobDTO.getIsLock() != null) {
            existJob.setIsLock(jobDTO.getIsLock());
        }

        if (jobDTO.getRequiredSkill() != null) {
            existJob.setRequiredSkill(jobDTO.getRequiredSkill());
        }

//        existJob.setPosition(jobDTO.getPosition());
//        existJob.setExpDate(jobDTO.getExpDate());
//        existJob.setRequirement(jobDTO.getRequirement());
//        existJob.setDescription(jobDTO.getDescription());
//        existJob.setBenefit(jobDTO.getBenefit());
//        existJob.setWorkLocation(jobDTO.getWorkLocation());
//        existJob.setStatus(jobDTO.getStatus());
//        existJob.setIsEdit(jobDTO.getIsEdit());
//        existJob.setIsLock(jobDTO.getIsLock());
//        existJob.setIsActive(jobDTO.getIsActive());
        iJobRepository.save(existJob);
    }

    @Override
    public Jobs getJobById(long id) {
        return iJobRepository.findById(id).orElseThrow(() -> new RuntimeException("Job not found"));
    }

    @Override
    public Page<Jobs> getJobByRecruiterId(long recruiterId, PageRequest pageRequest) {
        Recruiters recruiters = recruiterService.getRecruiter(recruiterId);
        return iJobRepository.findByPostedBy(recruiters, pageRequest);
    }

    @Override
    public Page<Jobs> getAllJob(PageRequest pageRequest) {
        return iJobRepository.findAllJob(pageRequest, "Opening", 0);
    }

    @Override
    public Page<Jobs> getAllJobAdmin(PageRequest pageRequest) {
        return iJobRepository.findAll(pageRequest);
    }

    @Override
    public Page<Jobs> searchJob(String SearchKeyword, PageRequest pageRequest) {

        return iJobRepository.searchJob(SearchKeyword, pageRequest);
    }

    @Override
    public Page<Jobs> searchJobAdmin(String SearchKeyword, PageRequest pageRequest) {
        return iJobRepository.searchJobAdmin(SearchKeyword, pageRequest);
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
            recommended.add(getJobById(id));
        }
        for (JsonNode job : cfJobs) {
            long id = job.asLong();
            recommended.add(getJobById(id));
        }
        return recommended;
    }

    @Override
    public SplitRcmResponse getRecommendedJobSplit(RecommenInputDTO recommenInputDTO) throws Exception {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8000/api/v1/hybrid_recommend_jobs";

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

        List<Jobs> cbJobList = new ArrayList<>();
        List<Jobs> cfJobList = new ArrayList<>();

        for (JsonNode job : cbJobs) {
            long id = job.asLong();
            cbJobList.add(getJobById(id));
        }
        for (JsonNode job : cfJobs) {
            long id = job.asLong();
            cfJobList.add(getJobById(id));
        }
        return new SplitRcmResponse(cbJobList.size(), cbJobList, cfJobList.size(), cfJobList);
    }

    public void updateLockJob(long jobId, long status) {
        Jobs jobs = iJobRepository.findById(jobId).orElseThrow(
                () -> new RuntimeException("job not found"));
        jobs.setIsLock(status);
        iJobRepository.save(jobs);
    }

    @Scheduled(cron = "0 5 0 * * *")//len lich chay luc 0:5 phut sang
    @Transactional//du lieu se duoc khoi phuc giong truoc do neu gap loi
    public void closeExpiredJobs() {
        int affectedJob = iJobRepository.closeExpiredJobs(LocalDate.now());
        System.out.println("to day close " + affectedJob + " job");
    }
}
