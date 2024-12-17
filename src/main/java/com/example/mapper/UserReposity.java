package com.example.mapper;

import com.example.model.User;

import java.util.List;

public interface UserReposity {
    public List<User> findAll();
}
