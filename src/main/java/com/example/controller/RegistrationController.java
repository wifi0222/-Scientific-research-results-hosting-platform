package com.example.controller;

import com.example.service.RegistrationService;
import com.example.service.ISendMailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/registration")
public class RegistrationController {

    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private ISendMailService sendMailService;

    @PostMapping("/sendVerificationCode")
    @ResponseBody
    public Map<String, Object> sendVerificationCode(@RequestParam("username") String username,
                                                    @RequestParam("email") String email) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 调用发送邮件服务
            boolean sent = sendMailService.sendEmail(username, email);
            if (sent) {
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("error", "用户名或邮箱已被注册，无法发送验证码！");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", "发送验证码时出现错误！");
        }
        return response;
    }


    @PostMapping("/submit")
    public String submitRegistration(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("email") String email,
            @RequestParam("roleType") String roleType,
            @RequestParam("reason") String reason,
            @RequestParam("verificationCode") String verificationCode,
            Model model) {

        // 校验验证码是否正确
        if (!registrationService.validateVerificationCode(username, verificationCode)) {
            model.addAttribute("error", "验证码错误或已过期！");
            return "registration";
        }

        // 校验用户名和邮箱是否存在
        String checkResult = registrationService.checkUserExistence(username, email);
        if (checkResult != null) {
            model.addAttribute("error", checkResult);
            return "registration";
        }

        // 提交注册信息
        boolean success = registrationService.submitRegistration(username, password, roleType, email, reason);
        if (success) {
            model.addAttribute("message", "注册申请已提交，等待管理员审核！");
            return "registrationSuccess";
        } else {
            model.addAttribute("error", "提交失败，请稍后重试！");
            return "registration";
        }
    }

    // 查看申请状态
    @PostMapping("/status")
    public String checkStatus(@RequestParam("email") String email, Model model) {
        // 查询注册状态
        String statusMessage = registrationService.checkApplicationStatus(email);

        if (statusMessage == null) {
            model.addAttribute("error", "邮箱未注册！");
        } else {
            model.addAttribute("message", statusMessage);
        }

        return "status"; // 返回状态页面
    }
}
