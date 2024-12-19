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

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    // 登录处理
    @PostMapping("/login")
    public String login(@RequestParam("usernameOrId") String usernameOrId,
                        @RequestParam("password") String password,
                        HttpSession session, // 注入 HttpSession 保存用户信息
                        Model model) {
        User user = userService.login(usernameOrId, password);
        if (user == null) {
            model.addAttribute("error", "账号不存在或密码错误！");
            return "login";
        }
        if (user.getStatus() == 0) {
            model.addAttribute("error", "账户已被禁用！");
            return "login";
        }

        // 登录成功，保存用户信息到 Session
        session.setAttribute("currentUser", user);

        // 根据角色跳转
        if ("teammember".equals(user.getRoleType())) {
            return "redirect:/user/browse?teammember=true";
        } else if ("member".equals(user.getRoleType())) {
            return "redirect:/user/browse";
        }
        model.addAttribute("error", "未知角色！");
        return "login";
    }

    // 信息浏览页面
    @GetMapping("/browse")
    public String browsePage(@RequestParam(value = "teammember", required = false) boolean isTeamMember,
                             HttpSession session,
                             Model model) {
        System.out.println("isTeamMember: " + isTeamMember); // 调试输出
        User currentUser = (User) session.getAttribute("currentUser"); // 从 Session 中获取当前用户
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果用户未登录，跳转到登录页面
        }

        // 将用户信息传递给前端
        model.addAttribute("isTeamMember", isTeamMember);
        model.addAttribute("user", currentUser);

        return "browse"; // 返回信息浏览页面
    }

    // 显示登录页面
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    // 个人信息页面
    @GetMapping("/profile")
    public String showProfilePage(HttpSession session, Model model) {
        // 从 Session 中获取当前用户信息
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);

        return "profile"; // 返回个人信息页面
    }

    // 更新个人信息
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam("name") String name,
                                @RequestParam("researchField") String researchField,
                                @RequestParam("contactInfo") String contactInfo,
                                @RequestParam("academicBackground") String academicBackground,
                                @RequestParam("researchAchievements") String researchAchievements,
                                HttpSession session, // 从 Session 中获取用户信息
                                Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }

        // 更新用户信息
        currentUser.setName(name);
        currentUser.setResearchField(researchField);
        currentUser.setContactInfo(contactInfo);
        currentUser.setAcademicBackground(academicBackground);
        currentUser.setResearchAchievements(researchAchievements);

        // 提交更新到审核表
        userService.submitForReview(currentUser);

        // 提示信息
        model.addAttribute("message", "信息已提交审核");

        return "profile"; // 返回到个人信息页面
    }
}
