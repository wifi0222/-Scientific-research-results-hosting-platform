package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public String login(@RequestParam("usernameOrId") String usernameOrId,
                        @RequestParam("password") String password,
                        Model model) {
        User user = userService.login(usernameOrId, password);
        if (user == null) {
            model.addAttribute("error", "账号不存在或密码错误！");
            return "login"; // 返回登录页面
        }
        if (user.getStatus() == 0) {
            model.addAttribute("error", "账户已被禁用！");
            return "login";
        }
        // 判断角色，重定向不同页面
        if ("teammember".equals(user.getRoleType())) {
            return "redirect:/user/profile"; // 个人信息页面
        } else if ("member".equals(user.getRoleType())) {
            return "redirect:/browse"; // 浏览页面
        }
        model.addAttribute("error", "未知角色！");
        return "login";
    }
    // GET 方法用于展示登录页面
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // 返回登录页面的视图名称
    }
}
