package com.project.jobportal.services;

import com.project.jobportal.DTOs.UserDTO;
import com.project.jobportal.models.Users;
import com.project.jobportal.repositories.IUserRepository;
import lombok.RequiredArgsConstructor;
import org.apache.catalina.User;
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

    @Override
    public void updateStatusUser(long userId, int status) {
        Users user = iUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("use not found"));
        user.setIsActive(status);
        iUserRepository.save(user);
    }

    @Override
    public void changePassword(long userId, String oldPassword, String newPassword) {
        Users user = iUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("use not found"));
        if (!oldPassword.equals(user.getPassword())) {
            throw new RuntimeException("Old password is not match!");
        }

        user.setPassword(newPassword);
        iUserRepository.save(user);
    }

    @Override
    public Users getUserById(long id) {
        Users user = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("use not found"));

        return user;
    }

    @Override
    public List<User> getAllUser() {
        return List.of();
    }

    @Override
    public Users login(String email, String password, String role) {
        Users users = iUserRepository.findByEmailAndPasswordAndRole(email, password, role);
        if (users == null) {
            throw new RuntimeException("Tài khoản hoặc mật khẩu không đúng");
        }
        return users;
    }

    @Override
    public List<User> filterJobs(String title, String position, Integer experience, Integer minSalary, Integer maxSalary) {
        return List.of();
    }

    @Override
    public void uploadAvt(long userId, String fileName) throws IOException {
        Users user = iUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("use not found"));
        Path oldPath = Paths.get("avtUser_uploads", user.getUrlAvatar());
        user.setUrlAvatar(fileName);
        Files.delete(oldPath);
        iUserRepository.save(user);
    }

    @Override
    public void updateUserByID(UserDTO userDTO, long id) throws IOException {
        Users user = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("use not found"));
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
                throw new RuntimeException("Số điện thoại đã tồn tại");
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


}
