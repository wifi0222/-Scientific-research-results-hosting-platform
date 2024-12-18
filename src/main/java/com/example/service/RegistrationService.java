package com.example.service;

public interface RegistrationService {
    boolean validateVerificationCode(String username, String verificationCode);
    String checkUserExistence(String username, String email);
    boolean submitRegistration(String username, String password, String roleType, String email, String reason);
    String checkApplicationStatus(String email); // 根据邮箱检查注册状态
}
