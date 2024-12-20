package com.example.service.Impl;

import com.example.mapper.UserMapper;
import com.example.mapper.CaptchaMapper;
import com.example.service.ForgotPasswordService;
import com.example.tool.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ForgotPasswordServiceImpl implements ForgotPasswordService {

    @Autowired
    private RedisUtil redisUtil;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CaptchaMapper captchaMapper;

    @Override
    public boolean checkUsernameAndEmail(String username, String email) {
        return userMapper.checkUsernameAndEmail(username, email) > 0;
    }

    @Override
    public boolean validateVerificationCode(String username, String verificationCode) {
        String redisKey = "email:session:" + username;
        String storedCode = (String) redisUtil.get(redisKey);
        System.out.println("in validateVerificationCode ForgotPasswordServiceImpl.java");
        System.out.println(redisKey);
        System.out.println(storedCode);

        return storedCode != null && storedCode.equals(verificationCode);
        //return captchaMapper.validateCaptcha(username, verificationCode) > 0;
    }

    @Override
    public String validateNewPassword(String username, String newPassword, String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) {
            return "两次输入的密码不一致！";
        }
        if (userMapper.checkOldPassword(username, newPassword) > 0) {
            return "新密码不能与旧密码相同！";
        }
        return null;
    }

    @Override
    public boolean updatePassword(String username, String newPassword) {
        return userMapper.updatePassword(username, newPassword) > 0;
    }
}
