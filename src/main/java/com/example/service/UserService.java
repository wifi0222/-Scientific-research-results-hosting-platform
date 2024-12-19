package com.example.service;

import com.example.model.User;

import java.util.List;

public interface UserService {
    public List<User> findAll();
    User login(String usernameOrId, String password);
    User getCurrentUser();
    void submitForReview(User user);
    void updatePasswordbyid(User user);
    boolean isDeactivationPending(int userID); // 检查注销申请是否已存在
    void submitDeactivationRequest(User user); // 提交注销申请
}