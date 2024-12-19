package com.example.service.Impl;

import com.example.mapper.UserMapper;
import com.example.model.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userReposity;
    private User currentUser;

    @Override
    public List<User> findAll() {
        return userReposity.findAll();
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
}