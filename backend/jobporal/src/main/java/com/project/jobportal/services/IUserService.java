package com.project.jobportal.services;

import com.project.jobportal.DTOs.UserDTO;
import com.project.jobportal.models.Users;
import org.apache.catalina.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.io.IOException;
import java.util.List;

public interface IUserService {
    void updateStatusUser(long userId, int status);

    void changePassword(long userId, String oldPassword, String newPassword);

    Users getUserById(long id);

    Page<Users> getAllUser(PageRequest pageRequest);

    Users login(String email, String password, String role);

    List<Users> filterJobs(String title, String position, Integer experience, Integer minSalary, Integer maxSalary);

    void uploadAvt(long userId, String fileName) throws IOException;

    void updateUserByID(UserDTO userDTO, long id) throws IOException;

    Users getUserByEmail(String email);
}
