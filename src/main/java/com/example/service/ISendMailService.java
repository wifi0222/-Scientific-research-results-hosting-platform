package com.example.service;

/**
 * 发送邮件service
 */
public interface ISendMailService {
    boolean sendEmail(String username, String recipient);
}
