package com.example.controller;

import com.example.service.ForgotPasswordService;
import com.example.service.ISendMailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/forgot-password")
public class ForgotPasswordController {

    @Autowired
    private ForgotPasswordService forgotPasswordService;

    @Autowired
    private ISendMailService sendMailService;

    /**
     * 验证用户名和邮箱是否匹配，并发送验证码
     */
    @PostMapping("/sendVerificationCode")
    @ResponseBody
    public Map<String, Object> sendVerificationCode(@RequestParam("username") String username,
                                                    @RequestParam("email") String email) {
        Map<String, Object> response = new HashMap<>();
        try {
            boolean matched = forgotPasswordService.checkUsernameAndEmail(username, email);
            if (!matched) {
                response.put("success", false);
                response.put("error", "用户名和邮箱不匹配！");
                return response;
            }

            // 发送验证码
            boolean sent = sendMailService.resendEmail(username, email);
            if (sent) {
                response.put("success", true);
                response.put("message", "验证码已发送到您的注册邮箱！");
            } else {
                response.put("success", false);
                response.put("error", "验证码发送失败，请稍后重试！");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", "系统错误，请稍后重试！");
        }
        return response;
    }

    /**
     * 验证验证码并修改密码
     */
    @PostMapping("/resetPassword")
    @ResponseBody
    public Map<String, Object> resetPassword(@RequestParam("username") String username,
                                             @RequestParam("verificationCode") String verificationCode,
                                             @RequestParam("newPassword") String newPassword,
                                             @RequestParam("confirmPassword") String confirmPassword) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 验证验证码
            boolean validCode = forgotPasswordService.validateVerificationCode(username, verificationCode);
            if (!validCode) {
                response.put("success", false);
                response.put("error", "验证码错误或已过期！");
                return response;
            }

            // 验证新密码
            String result = forgotPasswordService.validateNewPassword(username, newPassword, confirmPassword);
            if (result != null) {
                response.put("success", false);
                response.put("error", result);
                return response;
            }

            // 更新密码
            boolean updated = forgotPasswordService.updatePassword(username, newPassword);
            if (updated) {
                response.put("success", true);
                response.put("message", "密码已成功修改！");
            } else {
                response.put("success", false);
                response.put("error", "修改密码失败，请稍后重试！");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", "系统错误，请稍后重试！");
        }
        return response;
    }
}
