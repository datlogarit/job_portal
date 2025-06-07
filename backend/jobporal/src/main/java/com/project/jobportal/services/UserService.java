package com.project.jobportal.services;

import com.project.jobportal.DTOs.UserDTO;
import com.project.jobportal.models.Jobs;
import com.project.jobportal.models.Users;
import com.project.jobportal.repositories.IUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {
    private final IUserRepository iUserRepository;
    private final JobService jobService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void updateStatusUser(long userId, int status) {
        Users user = iUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("user not found"));
        user.setIsActive(status);
        iUserRepository.save(user);
    }

    @Override
    public void changePassword(long userId, String oldPassword, String newPassword) {
        Users user = iUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("user not found"));
        if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
            throw new RuntimeException("Old password is not match!");
        }

        user.setPassword(passwordEncoder.encode(newPassword));
        iUserRepository.save(user);
    }

    @Override
    public Users getUserById(long id) {
        Users user = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));

        return user;
    }

    @Override
    public Page<Users> getAllUser(PageRequest pageRequest) {
        return iUserRepository.findAll(pageRequest);
    }

    @Override
    public Users login(String email, String password, String role) {
        Users users = iUserRepository.findByEmailAndPasswordAndRole(email, password, role);
        if (users == null) {
            throw new RuntimeException("Email or password not match");
        }
        return users;
    }

    @Override
    public List<Users> filterJobs(String title, String position, Integer experience, Integer minSalary, Integer maxSalary) {
        return List.of();
    }

    @Override
    public void uploadAvt(long userId, String fileName) throws IOException {
        Users user = iUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("user not found"));
//        Path oldPath = Paths.get("avtUser_uploads", user.getUrlAvatar());
        user.setUrlAvatar(fileName);
//        Files.delete(oldPath);
        iUserRepository.save(user);
    }

    @Override
    public void updateUserByID(UserDTO userDTO, long id) throws IOException {
        Users user = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));
        boolean isChange = false;
        if (userDTO.getPassword() != null) {
            user.setPassword(userDTO.getPassword());
            isChange = true;
        }
        if (userDTO.getName() != null) {
            user.setName(userDTO.getName());
            isChange = true;
        }
        if (userDTO.getPhoneNumber() != null) {
            if (iUserRepository.existsByPhoneNumber(userDTO.getPhoneNumber())
            ) {
                throw new RuntimeException("The phone number already existed");
            }
            user.setPhoneNumber(userDTO.getPhoneNumber());
            isChange = true;
        }
        if (userDTO.getDob() != null) {
            user.setDob(userDTO.getDob());
            isChange = true;
        }
        if (isChange) {
            iUserRepository.save(user);
        }
    }

    @Override
    public Users getUserByEmail(String email) {
        Users user = iUserRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("user not found"));
        return user;
    }

    public void BANUser(long id) {
        Users user = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));
//        return user;
        updateStatusUser(id, 0);//update user
        if (user.getRole().equals("recruiter")) {
            Page<Jobs> jobs = jobService.getJobByRecruiterId(id
                    , PageRequest.of(0, 100, Sort.by("createdAt").descending()));
            if (!jobs.isEmpty()) {
                for (Jobs job : jobs) {
                    jobService.updateLockJob(job.getId(), 1);
                }
            }
        }
    }

    public void UnBANUser(long id) {
        Users user = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));
//        return user;
        updateStatusUser(id, 1);//update user
        if (user.getRole().equals("recruiter")) {
            Page<Jobs> jobs = jobService.getJobByRecruiterId(id
                    , PageRequest.of(0, 100, Sort.by("createdAt").descending()));
            if (!jobs.isEmpty()) {
                for (Jobs job : jobs) {
                    jobService.updateLockJob(job.getId(), 0);
                }
            }
        }
    }

    public void migratePasswordsToBCrypt() {
        List<Users> allUser = iUserRepository.findAll();

        for (Users user : allUser) {
            String currentPassword = user.getPassword();


            // Băm mật khẩu và cập nhật lại
            String hashed = passwordEncoder.encode(currentPassword);
            user.setPassword(hashed);
        }

        iUserRepository.saveAll(allUser);
        System.out.println("✅ Migrate hoàn tất: đã băm tất cả mật khẩu chưa mã hóa.");
    }
}
