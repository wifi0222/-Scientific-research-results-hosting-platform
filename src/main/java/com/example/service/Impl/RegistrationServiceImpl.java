package com.example.service.Impl;

import com.example.mapper.RegistrationMapper;
import com.example.model.RegistrationReview;
import com.example.service.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class RegistrationServiceImpl implements RegistrationService {

    @Autowired
    private RegistrationMapper registrationMapper;

    @Override
    public boolean validateVerificationCode(String username, String verificationCode) {
        String storedCode = registrationMapper.getVerificationCodeByUsername(username);
        return storedCode != null && storedCode.equals(verificationCode);
    }

    @Override
    public String validateNewPassword(String username, String newPassword, String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) {
            return "两次输入的密码不一致！";
        }
        return null;
    }

    @Override
    public String checkUserExistence(String username, String email) {
        boolean usernameExists = registrationMapper.usernameExists(username);
        boolean emailExists = registrationMapper.emailExists(email);

        if (usernameExists) {
            return "用户名已被注册！";
        } else if (emailExists) {
            return "邮箱已被注册！";
        }
        return null;
    }

    @Override
    public boolean submitRegistration(String username, String password, String roleType, String email, String reason) {
        return registrationMapper.insertRegistrationRequest(username, password, roleType, email, reason, new Date(), 0) > 0;
    }

    @Override
    public String checkApplicationStatus(String email) {
        Integer status = registrationMapper.getApplicationStatusByEmail(email);

        if (status == null) {
            return null; // 邮箱未注册
        }

        switch (status) {
            case 0:
                return "状态：待审核";
            case 1:
                return "状态：审核成功";
            case -1:
                return "状态：审核失败";
            default:
                return "状态未知，请联系管理员！";
        }
    }

    @Override
    public List<RegistrationReview> getAllRegistrationReviews() {
        return registrationMapper.getAllRegistrationReviews();
    }

    @Override
    public RegistrationReview getRegisterByusername(String username) {
        return registrationMapper.getRegisterByusername(username);
    }

    @Override
    public int updateFailResult(String username, String refuseReason) {
        return registrationMapper.updateFailResult(username, refuseReason);
    }

    @Override
    public int updateSuccessResult(String username) {
        return registrationMapper.updateSuccessResult(username);
    }
}
