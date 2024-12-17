package com.example.controller;

import com.example.model.User;
import com.example.service.ISendMailService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
/*
超级管理员进行用户管理和权限管理
 */
@Controller
public class SuperController {
    @Autowired
    private UserService userService;

    @Autowired
    private ISendMailService sendMailService;


    //用户点击用户管理进行
    @GetMapping("/UserManagement")
    public String index(Model model){
        List<User> users = userService.findAll();
        model.addAttribute("users", users);
        return "index";
    }

    @GetMapping("/yanzhengma")
    public String getVeriy(@RequestParam("email")String email, Model model) throws Exception {
        sendMailService.sendEmail(email);
        return "index";

    }
}

