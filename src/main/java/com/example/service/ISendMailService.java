package com.example.service;

/**
 * 发送邮件service
 */
public interface ISendMailService {
    boolean sendEmail(String username, String recipient);
    boolean resendEmail(String username, String recipient);
    boolean sendMessageEmail(String sendEmailAddress, String message);
    String resetPassword(String recipient);
}
