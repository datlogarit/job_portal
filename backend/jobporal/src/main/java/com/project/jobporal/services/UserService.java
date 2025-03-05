package com.project.jobporal.services;

import com.project.jobporal.models.Users;
import com.project.jobporal.repositories.IUserRepository;
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
    public void updateStatusUser() {

    }

    @Override
    public void crateUser() {

    }

    @Override
    public Users getUserById(long id) {
        return null;
    }

    @Override
    public List<User> getAllUser() {
        return List.of();
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

}
