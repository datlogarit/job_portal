package com.project.jobportal.controllers;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping
@RestController
public class SecurityController {
    @GetMapping("")
    public String Security(Authentication authentication) {
        return "hello " + authentication.getName() + "🎉";
    }
}
