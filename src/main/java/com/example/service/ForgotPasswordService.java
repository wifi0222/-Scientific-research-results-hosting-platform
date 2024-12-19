package com.example.service;

public interface ForgotPasswordService {
    boolean checkUsernameAndEmail(String username, String email);
    boolean validateVerificationCode(String username, String verificationCode);
    String validateNewPassword(String username, String newPassword, String confirmPassword);
    boolean updatePassword(String username, String newPassword);
}
