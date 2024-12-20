package com.example.service;

import com.example.model.RegistrationReview;

import java.util.List;

public interface RegistrationService {
    boolean validateVerificationCode(String username, String verificationCode);

    String validateNewPassword(String username, String newPassword, String confirmPassword);

    String checkUserExistence(String username, String email);
    boolean submitRegistration(String username, String password, String roleType, String email, String reason);
    String checkApplicationStatus(String email); // 根据邮箱检查注册状态
    public List<RegistrationReview> getAllRegistrationReviews();
    public RegistrationReview getRegisterByusername(String username);
    public int updateFailResult(String username, String refuseReason);
    public int updateSuccessResult(String username);

}
