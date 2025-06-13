package com.project.jobportal.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.jobportal.DTOs.ApplicationDTO;
import com.project.jobportal.DTOs.CompanyDTO;
import com.project.jobportal.DTOs.InteractionDTO;
import com.project.jobportal.services.ApplicationService;
import com.project.jobportal.services.InteractionService;
import com.project.jobportal.utilities.HandleFile;
import com.project.jobportal.utilities.helper;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
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

    @GetMapping("/job/{jobId}")//lấy ra thong tin tất ca cac application theo jobId
    public ResponseEntity<?> getApplicationByJobId(@PathVariable(name = "jobId") long jobId) {
        return ResponseEntity.ok(applicationService.getApplicationByJobId(jobId));
    }

    @GetMapping("/resume/{resumeName}")
    public ResponseEntity<byte[]> getResume(@PathVariable String resumeName) throws IOException {
        File resumeFile = new File("cv_application/" + resumeName);

        if (!resumeFile.exists()) {
            return ResponseEntity.notFound().build();
        }

        // Kiểm tra phần mở rộng
        String lowerName = resumeName.toLowerCase();
        byte[] fileContent;
        File fileToReturn;

        if (lowerName.endsWith(".docx") || lowerName.endsWith(".doc")) {
            // Nếu là file docx → chuyển sang pdf
            File pdfFile = helper.convertWordToPdf(resumeFile);
            fileContent = Files.readAllBytes(pdfFile.toPath());

            // Sau khi đọc xong thì xóa file pdf tạm thời
            pdfFile.delete();

            fileToReturn = pdfFile;
        } else if (lowerName.endsWith(".pdf")) {
            // Nếu là file PDF → đọc luôn
            fileContent = Files.readAllBytes(resumeFile.toPath());
            fileToReturn = resumeFile;
        } else {
            // Không hỗ trợ định dạng khác
            return ResponseEntity
                    .badRequest()
                    .body(("Unsupported file type: " + resumeName).getBytes(StandardCharsets.UTF_8));
        }

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + fileToReturn.getName() + "\"")
                .contentType(MediaType.APPLICATION_PDF)
                .contentLength(fileContent.length)
                .body(fileContent);
    }


}
