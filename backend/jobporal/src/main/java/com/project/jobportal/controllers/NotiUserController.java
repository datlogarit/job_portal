package com.project.jobportal.controllers;

import com.project.jobportal.DTOs.NotiUserDTO;
import com.project.jobportal.services.NotiUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/notiuser")
@RequiredArgsConstructor
public class NotiUserController {
    private final NotiUserService notiUserService;

    @PostMapping("")
    public ResponseEntity<?> createNotiUser(@RequestBody NotiUserDTO notiUserDTO) {
        notiUserService.createUserNoti(notiUserDTO);
        return ResponseEntity.ok("create notiuser successfully");
    }

    @PutMapping("")//update status view post for when user click in post
    public ResponseEntity<?> updateNotiUser(@RequestBody NotiUserDTO notiUserDTO) {
        notiUserService.updateUserNoti(notiUserDTO);
        return ResponseEntity.ok("update notiuser successfully");
    }

    @GetMapping("/{id}")//lay ds thong bao theo userId
    public ResponseEntity<?> getNotiByUser(@PathVariable long id) {
        return ResponseEntity.ok(notiUserService.getNotiByUserId(id));
    }
}
