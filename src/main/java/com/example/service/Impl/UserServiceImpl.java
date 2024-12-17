package com.example.service.Impl;

import com.example.mapper.UserReposity;
import com.example.model.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserReposity userReposity;

    @Override
    public List<User> findAll() {
        return userReposity.findAll();
    }
}