package com.example.service;

import com.example.model.User;

import java.util.List;

public interface UserService {
    public List<User> findAll();
    User login(String usernameOrId, String password);
    User getCurrentUser();
    void submitForReview(User user);
    void updatePasswordbyid(User user);
}