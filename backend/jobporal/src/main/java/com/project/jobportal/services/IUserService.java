package com.project.jobportal.services;

import com.project.jobportal.models.Users;
import org.apache.catalina.User;

import java.io.IOException;
import java.util.List;

public interface IUserService {

    void updateStatusUser();

    Users getUserById(long id);

    List<User> getAllUser();

    Users login(String email, String password, String role);

    List<User> filterJobs(String title, String position, Integer experience, Integer minSalary, Integer maxSalary);

    void uploadAvt(long userId, String fileName) throws IOException;
}
