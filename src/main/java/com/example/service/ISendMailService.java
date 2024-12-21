package com.example.service;

/**
 * 发送邮件service
 */
public interface ISendMailService {
    boolean checkEmail(String recipient);
    boolean checkUsername(String username);
    boolean sendEmail(String username, String recipient);
    boolean sendMessageEmail(String sendEmailAddress, String message);
    String resetPassword(String recipient);
}
