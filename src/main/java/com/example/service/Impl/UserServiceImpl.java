package com.example.service.Impl;

import com.example.mapper.AdministratorMapper;
import com.example.mapper.UserMapper;
import com.example.model.MemberReview;
import com.example.model.RegistrationReview;
import com.example.model.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userReposity;
    @Autowired
    private AdministratorMapper administratorReposity;

    private User currentUser;

    @Override
    public List<User> findAllTeamAdmin() {
        return userReposity.findAllTeamAdmin();
    }

    @Override
    public List<User> findAllTeamMember() {
        return userReposity.findAllTeamMember();
    }

    //在用户注册、新增用户时检查用户名是否存在
    @Override
    public User findByUserName(String username){return userReposity.findByUsername(username);}

    @Override
    public User findById(int id) {
        return userReposity.findByUserId(id);
    }


    @Override
    public User login(String usernameOrId, String password) {
        User user = null;

        // 判断输入的是用户名还是用户ID
        if (usernameOrId.matches("\\d+")) { // 如果是纯数字
            int userId = Integer.parseInt(usernameOrId);
            user = userReposity.findByUserId(userId); // 根据 userID 查询
        } else {
            user = userReposity.findByUsername(usernameOrId); // 根据 username 查询
        }

        // 检查用户是否存在以及密码是否正确
        if (user == null || !user.getPassword().equals(password)) {
            return null; // 账号不存在或密码错误
        }
        return user;
    }

    @Override
    public int updateTeamAdmin(User user) {
        return userReposity.updateTeamAdminInfo(user);
    }

    @Override
    public int addTeamAdmin(String username, String password) {
        //向用户表插入
        userReposity.insertTeamAdminToUser(username,password);
        //通过username查找userID
        User user=userReposity.findByUsername(username);
        //向权限表插入
        return administratorReposity.insertTeamAdminToAdministrator(user.getUserID());
    }

    @Override
    public int deleteTeamAdmin(int adminId) {
        administratorReposity.deleteTeamAdminFromAdministrator(adminId);
        return userReposity.deleteUser(adminId);
    }

    @Override
    public int addTeamMember(User user) {
        return userReposity.addTeamMember(user);
    }

    @Override
    public int updateTeamMember(User user) {
        return userReposity.updateTeamMember(user);
    }

    @Override
    public int updateTeamMemberInfo(MemberReview memberReview) {
        return userReposity.updateTeamMemberInfo(memberReview);
    }

    @Override
    public User getCurrentUser() {
        return currentUser;
    }

    @Override
    public void submitForReview(User user) {
        // 调用 MyBatis Mapper 插入数据到审核表
        userReposity.insertReview(user);
    }

    @Override
    public void updatePasswordbyid(User user) {
        userReposity.updatePassword(user);
    }

    @Override
    public boolean isDeactivationPending(int userID) {
        return userReposity.checkDeactivationRequest(userID) > 0; // 查询记录是否存在
    }

    @Override
    public void submitDeactivationRequest(User user) {
        userReposity.insertDeactivationRequest(user.getUserID());
    }

    @Override
    public int addNewUser(RegistrationReview registrationReview){
        return userReposity.addNewUser(registrationReview);
    }

    @Override
    public List<User> findTeamMemberAndVisitor(){
        return userReposity.findTeamMemberAndVisitor();
    }

    @Override
    public int deleteById(int userID){
        return userReposity.deleteById(userID);
    }

    @Override
    public int ResetPassword(int userID,String password) {
        return userReposity.ResetPassword(userID,password);
    }

    @Override
    public List<User> searchUsers(String username, String roleType, Integer status, String registrationTime, String email) {
        return userReposity.searchUsers(username,roleType,status,registrationTime,email);
    }

}