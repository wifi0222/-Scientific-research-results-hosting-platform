package com.example.service;

import com.example.model.User;

import java.util.List;

public interface UserService {
    public List<User> findAllTeamAdmin();
    public User findByUserName(String username);
    public User findById(int id);
    public User getCurrentUser();
    public void submitForReview(User user);
    public void updatePasswordbyid(User user);
    public boolean isDeactivationPending(int userID);
    public void submitDeactivationRequest(User user);
    User login(String usernameOrId, String password);
    public int updateTeamAdmin(User user);
    public int addTeamAdmin(String username, String password);
    public int deleteTeamAdmin(int adminId);
}