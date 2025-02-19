package com.project.jobporal.services;

import com.project.jobporal.models.Users;
import org.apache.catalina.User;

import java.util.List;

public interface IUserService {

    void updateStatusUser();

    void crateUser();

    Users getUserById(long id);

    List<User> getAllUser();

}
