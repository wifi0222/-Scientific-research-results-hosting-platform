package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import com.example.tool.RedisUtil;
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
    @Autowired
    private RedisUtil redisUtil;

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

        // 将用户信息保存到 Redis 中
        String redisKey = "user:session:" + user.getUserID();
        redisUtil.set(redisKey, "aaaaaaaaaaaaaaaaaaa");

        // 登录成功，保存用户信息到 Session
        session.setAttribute("currentUser", user);

        // 根据角色跳转
        if ("teammember".equals(user.getRoleType())) {
            return "redirect:/browse?teammember=true";
        } else if ("member".equals(user.getRoleType())) {
            return "redirect:/browse?member=true";
        }
        model.addAttribute("error", "未知角色！");
        return "login";
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
    // 显示修改密码页面
    @GetMapping("/change-password")
    public String showChangePasswordPage() {
        return "change-password"; // 确保存在 change-password.jsp
    }

    // 处理修改密码请求
    @PostMapping("/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpSession session, // 从 Session 中获取当前用户
                                 Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }

        // 验证旧密码是否正确
        if (!currentUser.getPassword().equals(oldPassword)) {
            model.addAttribute("error", "旧密码错误！");
            return "change-password";
        }

        // 验证新密码是否与旧密码相同
        if (newPassword.equals(oldPassword)) {
            model.addAttribute("error", "新密码不能与旧密码相同！");
            return "change-password";
        }

        // 验证两次输入的新密码是否一致
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "两次输入的新密码不一致！");
            return "change-password";
        }

        // 更新密码
        currentUser.setPassword(newPassword);
        userService.updatePasswordbyid(currentUser);

        // 提示成功信息
        model.addAttribute("message", "密码修改成功！");
        return "change-password";
    }

    // 显示注销申请页面
    @GetMapping("/deactivate")
    public String showDeactivationPage() {
        return "deactivate"; // 确保存在 deactivate.jsp
    }

    // 处理注销申请请求
    @PostMapping("/deactivate")
    public String handleDeactivationRequest(@RequestParam("password") String password,
                                            HttpSession session, // 从 Session 获取当前用户
                                            Model model) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }

        // 验证密码是否正确
        if (!currentUser.getPassword().equals(password)) {
            model.addAttribute("error", "密码错误！");
            return "deactivate";
        }

        // 检查注销信息审核表中是否已有记录
        if (userService.isDeactivationPending(currentUser.getUserID())) {
            model.addAttribute("error", "您已申请注销，请耐心等待！");
            return "deactivate";
        }

        // 插入注销申请到注销信息审核表
        userService.submitDeactivationRequest(currentUser);

        model.addAttribute("message", "注销申请已提交，等待管理员审核！");
        return "deactivate";
    }

    // “用户互动”模块，提问
    @GetMapping("/askQuestion")
    public String askQuestion(HttpSession session, Model model) {
        // 从 Session 中获取当前用户信息
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);

        return "Question/ask-question"; // 返回提问页面
    }

    // “我的反馈”模块，查看回复
    @GetMapping("/checkReply")
    public String checkReply(HttpSession session, Model model) {
        // 从 Session 中获取当前用户信息
        User currentUser = (User) session.getAttribute("currentUser");

        // 优先从 Redis 获取
        String redisKey = "user:session:" + currentUser.getUserID();
        String a = (String) redisUtil.get(redisKey);
        System.out.println(a);

//        if (currentUser == null) {
//            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
//        }

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);

        // 将用户ID存储到Session中
        session.setAttribute("userID", currentUser.getUserID());

        // 返回查看回复页面，不需要在URL上显示userID
        return "redirect:/questions/my-questions"; // 直接跳转到我的问题页面
    }

}
