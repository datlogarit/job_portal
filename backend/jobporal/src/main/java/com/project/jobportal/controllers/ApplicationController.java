package com.project.jobportal.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.DTOs.CompanyDTO;
import com.project.jobportal.DTOs.InteractionDTO;
import com.project.jobportal.services.ApplicationService;
import com.project.jobportal.services.InteractionService;
import com.project.jobportal.utilities.HandleFile;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("api/v1/application")
@RequiredArgsConstructor
public class ApplicationController {
    private final ApplicationService applicationService;

    private final HandleFile handleFile;

    @PostMapping(value = "", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> createApplication(@RequestPart("info") String ApplicationJson,//data nhận là String, hài thật chứ
                                               @RequestPart("file") MultipartFile file,
                                               BindingResult result) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        ApplicationDTO applicationDTO = objectMapper.readValue(ApplicationJson, ApplicationDTO.class);
        try {
            handleFile.validateFile(file);
            String fileName = file.getOriginalFilename();

            //chi can file ket thuc la pdf hoac docx
//            -> neu file ket thuc khac pdf va ket thuc khac doxs thi return response;
            if (!fileName.endsWith(".pdf") && !fileName.endsWith(".docx") && !fileName.endsWith(".doc")) {
                return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE).body("only accept pdf and docx file");
            }
            String newFileName = handleFile.storeFile(file, "cv_application");

            applicationService.createApplication(applicationDTO, newFileName);
            return ResponseEntity.ok("create application successfully");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    @PutMapping("/{id}")
    public ResponseEntity<?> updateStatusApplication(@PathVariable(name = "id") long id, @RequestBody ApplicationDTO applicationDTO) {
        applicationService.updateStatusApplication(id, applicationDTO);
        return ResponseEntity.ok("update application successfully with id = " + id);
    }

    @GetMapping("/{applicantId}/{jobId}")//lấy ra 1 application applicantId va jobId
    public ResponseEntity<?> getApplicationById(@PathVariable(name = "applicantId") long applicantId,
                                                @PathVariable(name = "jobId") long jobId) {
        return ResponseEntity.ok(applicationService.getApplicationByApplicantIdAndJobId(applicantId, jobId));
    }

    @GetMapping("/{userId}")//lấy ra thong tin tất ca cac application theo userId
    public ResponseEntity<?> getAllInteractionByUserId(@PathVariable(name = "userId") long userId) {
        return ResponseEntity.ok(applicationService.getAllApplicationByApplicantId(userId));
    }

}
