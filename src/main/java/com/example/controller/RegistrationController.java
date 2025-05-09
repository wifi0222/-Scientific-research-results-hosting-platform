package com.example.controller;

import com.example.service.RegistrationService;
import com.example.service.ISendMailService;
import com.example.tool.OpenSSLUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<Map<String, Object>> sendVerificationCode(@RequestParam("username") String username,
                                                                    @RequestParam("email") String email) {
        Map<String, Object> response = new HashMap<>();
        try {
            System.out.println("调用发送邮件服务");
            boolean sent = sendMailService.sendEmail(username, email);
            boolean emailcheck = sendMailService.checkEmail(email);
            boolean usernamecheck = sendMailService.checkUsername(username);
            if(emailcheck){
                if(usernamecheck){
                    if (sent) {
                        System.out.println("成功发送邮件");
                        response.put("success", true);
                        response.put("message", "验证码发送成功!");
                    } else {
                        System.out.println("未成功发送邮件");
                        response.put("success", false);
                        response.put("error", "未成功发送邮件！");
                    }
                }else{
                    response.put("success", false);
                    response.put("error", "用户名已被注册，无法发送验证码！");
                }

            }else {
                response.put("success", false);
                response.put("error", "邮箱已被注册，无法发送验证码！");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("error", "发送验证码时出现错误！");
        }
        return ResponseEntity.ok(response);
    }




    @PostMapping("/submit")
    public String submitRegistration(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("confirmpassword") String confirmPassword,
            @RequestParam("email") String email,
            @RequestParam("roleType") String roleType,
            @RequestParam("reason") String reason,
            @RequestParam("verificationCode") String verificationCode,
            Model model) {

        // 验证密码
        String result = registrationService.validateNewPassword(username, password, confirmPassword);
        if (result != null) {
            model.addAttribute("error", result); // 错误信息通过Model传递到视图
            model.addAttribute("username", username); // 保留用户名
            model.addAttribute("email", email); // 保留邮箱
            model.addAttribute("roleType", roleType); // 保留角色类型
            model.addAttribute("reason", reason); // 保留申请理由
            return "registration"; // 返回注册页面
        }

        // 校验验证码是否正确
        if (!registrationService.validateVerificationCode(username, verificationCode)) {
            model.addAttribute("error", "验证码错误或已过期！");
            model.addAttribute("username", username); // 保留用户名
            model.addAttribute("email", email); // 保留邮箱
            model.addAttribute("roleType", roleType); // 保留角色类型
            model.addAttribute("reason", reason); // 保留申请理由
            return "registration"; // 返回注册页面
        }

        // 校验用户名和邮箱是否存在
        String checkResult = registrationService.checkUserExistence(username, email);
        if (checkResult != null) {
            model.addAttribute("error", checkResult);
            model.addAttribute("username", username); // 保留用户名
            model.addAttribute("email", email); // 保留邮箱
            model.addAttribute("roleType", roleType); // 保留角色类型
            model.addAttribute("reason", reason); // 保留申请理由
            return "registration"; // 返回注册页面
        }

        // 提交注册信息
        // 加密
        String encryptedPassword = OpenSSLUtil.encrypt(password);
        boolean success = registrationService.submitRegistration(username, encryptedPassword, roleType, email, reason);
        if (success) {
            model.addAttribute("message", "注册申请已提交，等待管理员审核！");
        } else {
            model.addAttribute("error", "提交失败，请稍后重试！");
        }

        return "registration"; // 返回注册页面
    }



    // 查看申请状态
    @PostMapping("/status")
    public String checkStatus(@RequestParam("email") String email, Model model) {
        // 查询注册状态
        String statusMessage = registrationService.checkApplicationStatus(email);
        boolean emailcheck = sendMailService.checkUserEmail(email);
        if (emailcheck){
            if (statusMessage == null) {
                model.addAttribute("error", "邮箱未注册！");
            } else {
                model.addAttribute("message", statusMessage);
            }
        }
        else{
            model.addAttribute("message", "邮箱已注册！");
        }
        return "status"; // 返回状态页面
    }
}
