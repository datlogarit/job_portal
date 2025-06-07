package com.project.jobportal.services;

import com.project.jobportal.DTOs.User_RecruiterDTO;
import com.project.jobportal.models.RecruiterVerifications;
import com.project.jobportal.repositories.ICompanyRepository;
import com.project.jobportal.repositories.IRecruiterVerificationRepository;
import com.project.jobportal.security.PasswordUtil;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.project.jobportal.models.Companies;
import com.project.jobportal.models.Recruiters;
import com.project.jobportal.models.Users;
import com.project.jobportal.repositories.IRecruiterRepository;
import com.project.jobportal.repositories.IUserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import lombok.RequiredArgsConstructor;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RecruiterService implements IRecruiterService {
    private final IRecruiterRepository iRecruiterRepository;
    private final IUserRepository iUserRepository;
    private final ICompanyRepository iCompanyRepository;
    private final IRecruiterVerificationRepository iRecruiterVerificationRepository;

    @Override
    public Recruiters login(String email, String password) {
        Recruiters recruiters = iRecruiterRepository.findByEmail(email);
        if (recruiters == null) {
            throw new RuntimeException("Email or password not match");
        }
        if (!PasswordUtil.matchPassword(password, recruiters.getUserId().getPassword())) {
            throw new RuntimeException("Email or password not match");
        }
        if (recruiters.getUserId().getIsActive() == 0) {
            throw new RuntimeException("This account has been locked");
        }
        return recruiters;
//        PasswordUtil.matchPassword(password, user.getPassword());
//        Recruiters recruiters = iRecruiterRepository.login(email, password);
//        if (recruiters == null) {
//            throw new RuntimeException("Email or password not match");
//        }
//        if (recruiters.getUserId().getIsActive() == 0) {
//            throw new RuntimeException("This account has been locked");
//        }
//        return recruiters;
    }

    @Override
    public void createRecruiter(User_RecruiterDTO userRecruiter) {
        String hashedPassword = PasswordUtil.hashPassword(userRecruiter.getPassword());
        if (iRecruiterRepository.findByEmail(userRecruiter.getEmail()) != null) {
            throw new RuntimeException("Email đã tồn tại");
        }
        Users newUser = Users.builder()
                .email(userRecruiter.getEmail())
                .password(hashedPassword)
                .name(userRecruiter.getName())
                .phoneNumber(userRecruiter.getPhoneNumber())
                .dob(userRecruiter.getDob())
                .role("recruiter")
                .urlAvatar("11651387_recruiter_avt.png")
                .isActive(1)
                .build();

        Recruiters recruiters = Recruiters.builder()
                .userId(newUser)
//                .companyId(existCompany)
//                .isVerify(0)
//                .numberOfPost(0)
//                .position(userRecruiter.getPosition())
                .build();
        iRecruiterRepository.save(recruiters);
    }

    @Override
    public void updateRecruiter(long id, User_RecruiterDTO userRecruiterDTO) {
        Users existUser = iUserRepository.findById(id).orElseThrow(() -> new RuntimeException("user not found"));
        existUser.setPassword(userRecruiterDTO.getPassword());
        existUser.setName(userRecruiterDTO.getName());
        existUser.setPhoneNumber(userRecruiterDTO.getPhoneNumber());
        existUser.setDob(userRecruiterDTO.getDob());
        existUser.setUrlAvatar(userRecruiterDTO.getUrlAvatar());
        Companies existCompany =
                iCompanyRepository.findById(userRecruiterDTO.getCompanyId()).orElseThrow();
        Recruiters existRecruiters = getRecruiter(id);
        existRecruiters.setUserId(existUser);
        existRecruiters.setCompanyId(existCompany);
//        existRecruiters.setIsVerify(userRecruiterDTO.getIsVerify());
//        existRecruiters.setNumberOfPost(userRecruiterDTO.getNumberOfPost());
//        existRecruiters.setPosition(userRecruiterDTO.getPosition());
        iRecruiterRepository.save(existRecruiters);
    }

    @Override
    public void updateCompany(long recruiterId, long companyId) {
        Recruiters recruiters = iRecruiterRepository.findById(recruiterId).orElseThrow(
                () -> new RuntimeException("Recruiter not found"));
        Companies companies = iCompanyRepository.findById(companyId).orElseThrow();
        recruiters.setCompanyId(companies);
        iRecruiterRepository.save(recruiters);
    }

    @Override
    public void updateVerification(long recruiterId, long verificationId) {
        Recruiters recruiters = iRecruiterRepository.findById(recruiterId).orElseThrow(
                () -> new RuntimeException("Recruiter not found"));
        RecruiterVerifications verifications = iRecruiterVerificationRepository.findById(verificationId).orElseThrow();
        recruiters.setVerifyId(verifications);
        iRecruiterRepository.save(recruiters);
    }

    @Override
    public void deleteRecruiter() {
        // TODO Auto-generated method stub
    }

    @Override
    public Recruiters getRecruiter(long id) {
        Recruiters recruiters = iRecruiterRepository.findById(id).orElseThrow(() -> new
                RuntimeException("Recruiter not found"));
        return recruiters;
    }

    @Override
    public Page<Recruiters> getAllRecruiters(PageRequest pageRequest) {
        return iRecruiterRepository.findAll(pageRequest);
    }


    //dung de fake du lieu
    public Recruiters createRecruiterFake(String email, String password, String name, long CompanyId) {
        Users newUser = Users.builder()
                .email(email)
                .password(password)
                .name(name)
                .role("recruiter")
                .urlAvatar("11651387_recruiter_avt.png")
                .isActive(1)
                .build();

        Companies existCompany =
                iCompanyRepository.findById(CompanyId).orElseThrow();
        Recruiters recruiters = Recruiters.builder()
                .userId(newUser)
                .companyId(existCompany)
//                .isVerify(0)
//                .numberOfPost(0)
//                .position("nha tuyen dung")
                .build();
        iRecruiterRepository.save(recruiters);
        return recruiters;
    }

    public List<Recruiters> findRecruiterVerified() {
        return iRecruiterRepository.findByVerifyIdIsNotNullAndVerifyIdStatus(1, Sort.by(Sort.Direction.DESC, "verifyId.createdAt"));
    }

    @Override
    public long countTotalRecruiter() {
        return iRecruiterRepository.count();
    }
}
