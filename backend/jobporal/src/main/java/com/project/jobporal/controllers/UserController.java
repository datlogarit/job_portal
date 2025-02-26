package com.project.jobporal.controllers;

import com.project.jobporal.DTOs.User_RecruiterDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/user")
public class UserController {
    //quyen cua tat ca user
    @PostMapping("")
    public ResponseEntity<?> register(@RequestBody @Valid User_RecruiterDTO userDTO, BindingResult result) {

        return null;
    }

    @GetMapping("login")
    public ResponseEntity<?> login(String token) {
        return null;
    }

    //cac quyen cua admin
    //sua doi trang thai (active)
    @PutMapping("active")
    public ResponseEntity<?> updateApplicant() {
        return null;
    }

    @GetMapping("")
    public ResponseEntity<?> getAllUser() {
        return null;
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getUserById(@PathVariable long id) {
        return null;
    }
}
