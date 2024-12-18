package com.example.mapper;

import com.example.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserReposity {
    public List<User> findAll();
    User findByUserId(@Param("userId") int userId); // 根据 userID 查询
    User findByUsername(@Param("username") String username); // 根据 username 查询
}
