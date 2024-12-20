package com.example.service;

import com.example.model.MemberReview;
import com.example.model.RegistrationReview;
import com.example.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserService {
    public List<User> findAllTeamAdmin();
    public List<User> findAllTeamMember();
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
    public int addTeamMember(User user);
    public int updateTeamMember(User user);
    public int updateTeamMemberInfo(MemberReview memberReview);
    public int addNewUser(RegistrationReview registrationReview);
    public List<User> findTeamMemberAndVisitor();
    public int deleteById(int userID);
    public int ResetPassword(int userID,String password);
    public List<User> searchUsers(String username,String roleType,Integer status,String registrationTime,String email);
}