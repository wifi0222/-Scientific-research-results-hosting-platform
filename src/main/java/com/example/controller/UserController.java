package com.example.controller;

import com.example.model.DeactivationReview;
import com.example.model.MemberReview;
import com.example.model.User;
import com.example.service.DeactivationService;
import com.example.service.MemberViewService;
import com.example.service.UserService;
import com.example.tool.OpenSSLUtil;
import com.example.tool.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private MemberViewService memberViewService;
    @Autowired
    private DeactivationService deactivationService;
    @Autowired
    private RedisUtil redisUtil;

    // 登录处理
    @PostMapping("/login")
    public String login(@RequestParam("usernameOrId") String usernameOrId,
                        @RequestParam("password") String password,
                        HttpSession session, // 注入 HttpSession 保存用户信息
                        Model model) {
        // 加密
        String encryptedPassword = OpenSSLUtil.encrypt(password);
        System.out.println("Encrypted Password: " + encryptedPassword);

        // 解密
        String decryptedPassword = OpenSSLUtil.decrypt(encryptedPassword);
        System.out.println("Decrypted Password: " + decryptedPassword);
        // 判断id还是name
        User user = userService.login(usernameOrId, encryptedPassword);
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
        redisUtil.set(redisKey, user);

        // 登录成功，保存用户信息到 Session
        session.setAttribute("currentUser", user);
        session.setMaxInactiveInterval(525600 * 60); // 525600 分钟 * 60 秒 = 一年

        // 根据角色跳转
        if ("TeamMember".equals(user.getRoleType())) {
            return "redirect:/browse";
        } else if ("Visitor".equals(user.getRoleType())) {
            return "redirect:/browse";
        } else if ("TeamAdmin".equals(user.getRoleType())) {
            return "redirect:/teamAdmin/achievements?type=1"; // 跳转到团队管理员成果管理页面
        } else if ("SuperAdmin".equals(user.getRoleType())) {
            return "redirect:/SuperController/auditAchievements?type=1";
        }
//        else if("SuperAdmin".equals(user.getRoleType())){
//
//        }
        model.addAttribute("error", "未知角色！");
        return "login";
//        return "redirect:/browse";
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

    // 显示个人页面
    @GetMapping("/memberProfile")
    public String showMemberProfile(HttpSession session, // 从 Session 中获取当前用户
                                       Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }
        String userRoleType = currentUser.getRoleType();

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        return "memberProfile";
    }

    // 更新个人信息
    @PostMapping("/profile/update")
    public String updateProfile(
            @RequestParam("name") String name,
            @RequestParam("researchField") String researchField,
            @RequestParam("contactInfo") String contactInfo,
            @RequestParam("academicBackground") String academicBackground,
            @RequestParam("researchAchievements") String researchAchievements,
            @RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile, // 头像文件
            HttpSession session,
            Model model) throws Exception {

        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            // 如果未登录，重定向到登录页面
            return "redirect:/login";
        }

        // 创建新用户对象并设置个人信息
        User newUser = new User();
        newUser.setUserID(currentUser.getUserID());
        newUser.setName(name);
        newUser.setResearchField(researchField);
        newUser.setContactInfo(contactInfo);
        newUser.setAcademicBackground(academicBackground);
        newUser.setResearchAchievements(researchAchievements);

        // 处理头像文件
        if (avatarFile != null && !avatarFile.isEmpty()) {
            // 定义头像保存路径
            String avatarFilePath = saveFile(avatarFile, "user_avatars\\", 1);
            // 设置头像文件路径
            newUser.setAvatarFile(avatarFilePath);
        }

        // 提交更新到数据库
        userService.submitForReview(newUser);

        // 设置提示信息
        model.addAttribute("message", "信息已提交审核");
        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);

        return "profile"; // 返回个人信息页面
    }

    // 文件保存方法：保存文件到指定目录并返回文件路径
    private String saveFile(MultipartFile file, String uploadDir, int type) throws Exception {
        String location = "D:\\作业\\大三上\\javaweb\\课设\\"; // 设置文件上传的目录


        if (file.isEmpty()) {
            return null;
        }

        // 生成唯一的文件名，防止文件名冲突
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        File dest = new File(location + uploadDir + fileName);

        // 确保目录存在，如果不存在则创建
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }

        // 将上传的文件保存到指定的路径
        file.transferTo(dest);

        // 如果是头像（type == 1），返回文件的绝对路径
        if (type == 1) {
            return location + uploadDir + fileName;
        } else {
            // 如果是其他文件类型（如科研附件），返回相对路径
            return "uploads\\" + uploadDir + fileName;
        }
    }



    // 查询修改审核状态，使用 GET 请求
    @GetMapping("/profile/status")
    public String checkProfileStatus(HttpSession session, Model model) {
        // 从 Session 中获取当前登录的用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            model.addAttribute("error", "用户未登录，请先登录！");
            return "login"; // 如果未登录，跳转到登录页面
        }

        int memberID = currentUser.getUserID();

        // 调用 Service 层获取审核状态
        MemberReview memberReview = memberViewService.findByMemberID(memberID);

        if (memberReview != null) {
            int modificationStatus = memberReview.getModificationStatus();
            model.addAttribute("modificationStatus", modificationStatus);

            if (modificationStatus == -1) {
                // 审核未通过，添加拒绝理由
                model.addAttribute("refuseReason", memberReview.getRefuseReason());
            }
        } else {
            // 如果没有找到审核记录
            model.addAttribute("modificationStatus", null);
        }
        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);

        return "profileStatus"; // 返回对应的 JSP 页面
    }

    // 显示修改密码页面
    @GetMapping("/change-password")
    public String showChangePasswordPage(HttpSession session, // 从 Session 中获取当前用户
                                         Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }
        String userRoleType = currentUser.getRoleType();

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        return "change-password"; // 确保存在 change-password.jsp
    }

    // 处理修改密码请求
    @PostMapping("/change-password")
    public String changePassword(@RequestParam("oldPassword") String oldPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword,
                                 HttpSession session, // 从 Session 中获取当前用户
                                 Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }
        String userRoleType = currentUser.getRoleType();

        // 加密
        String encryptedOldPassword = OpenSSLUtil.encrypt(oldPassword);
        String encryptedNewPassword = OpenSSLUtil.encrypt(newPassword);
        String encryptedConfirmPassword = OpenSSLUtil.encrypt(confirmPassword);

        // 验证旧密码是否正确
        if (!currentUser.getPassword().equals(encryptedOldPassword)) {
            model.addAttribute("error", "旧密码错误！");
            // 将用户信息传递给前端
            model.addAttribute("user", currentUser);
            model.addAttribute("userRoleType", userRoleType);
            return "change-password";
        }

        // 验证新密码是否与旧密码相同
        if (newPassword.equals(oldPassword)) {
            model.addAttribute("error", "新密码不能与旧密码相同！");
            // 将用户信息传递给前端
            model.addAttribute("user", currentUser);
            model.addAttribute("userRoleType", userRoleType);
            return "change-password";
        }

        // 验证两次输入的新密码是否一致
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "两次输入的新密码不一致！");
            // 将用户信息传递给前端
            model.addAttribute("user", currentUser);
            model.addAttribute("userRoleType", userRoleType);
            return "change-password";
        }


        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);

        // 更新密码
        currentUser.setPassword(encryptedNewPassword);
        userService.updatePasswordbyid(currentUser);

        // 提示成功信息
        model.addAttribute("message", "密码修改成功！");
        return "change-password";
    }

    // 显示注销申请页面
    @GetMapping("/deactivate")
    public String showDeactivationPage(HttpSession session, // 从 Session 中获取当前用户
                                       Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }
        String userRoleType = currentUser.getRoleType();

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        return "deactivate"; // 确保存在 deactivate.jsp
    }

    // 处理注销申请请求
    @PostMapping("/deactivate")
    public String handleDeactivationRequest(@RequestParam("password") String password,
                                            HttpSession session, // 从 Session 获取当前用户
                                            Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }
        String userRoleType = currentUser.getRoleType();

        // 验证密码是否正确
        if (!currentUser.getPassword().equals(password)) {
            model.addAttribute("user", currentUser);
            model.addAttribute("userRoleType", userRoleType);
            model.addAttribute("error", "密码错误！");
            return "deactivate";
        }

        // 检查注销信息审核表中是否已有记录
        if (userService.isDeactivationPending(currentUser.getUserID())) {
            model.addAttribute("user", currentUser);
            model.addAttribute("userRoleType", userRoleType);
            model.addAttribute("error", "您已申请注销，请耐心等待！");
            return "deactivate";
        }

        // 插入注销申请到注销信息审核表
        userService.submitDeactivationRequest(currentUser);
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        model.addAttribute("message", "注销申请已提交，等待管理员审核！");
        return "deactivate";
    }

    // 查询注销审核状态，使用 GET 请求
    @GetMapping("/deactivate/status")
    public String checkDeactivateStatus(HttpSession session, Model model) {
        // 从 Session 中获取当前登录的用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            model.addAttribute("error", "用户未登录，请先登录！");
            return "login"; // 如果未登录，跳转到登录页面
        }
        String userRoleType = currentUser.getRoleType();

        int memberID = currentUser.getUserID();

        // 调用 Service 层获取审核状态
        DeactivationReview deactivationReview = deactivationService.findByMemberID(memberID);

        if (deactivationReview != null) {
            int deactivationStatus = deactivationReview.getDeactivationStatus();
            model.addAttribute("deactivationStatus", deactivationStatus);
        } else {
            // 如果没有找到审核记录
            model.addAttribute("deactivationStatus", null);
        }

        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        return "deactivationStatus"; // 返回对应的 JSP 页面
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

        // 这里只是测试一下 Redis，没什么卵用
        String redisKey = "user:session:" + currentUser.getUserID();
        User user = (User) redisUtil.get(redisKey);
        System.out.println(user);

        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);

        // 将用户ID存储到Session中
        session.setAttribute("userID", currentUser.getUserID());

        // 返回查看回复页面，不需要在URL上显示userID
        return "redirect:/questions/my-questions"; // 直接跳转到我的问题页面
    }

    //后台管理登录
    @GetMapping("/ManagementLogin")
    public String ManagementLogin(@RequestParam("usernameOrId") String usernameOrId,
                                  @RequestParam("password") String password,
                                  HttpSession session, // 注入 HttpSession 保存用户信息
                                  Model model) {
        User user = userService.login(usernameOrId, password);
        if (user == null) {
            model.addAttribute("error", "账号不存在或密码错误！");
            return "ManagementLogin";
        }
        if (user.getStatus() == 0) {
            model.addAttribute("error", "账户已被禁用！");
            return "ManagementLogin";
        }

        // 登录成功，保存用户信息到 Session
        session.setAttribute("currentUser", user);
        session.setAttribute("userRoleType", user.getRoleType());
        // 根据角色跳转
        if ("TeamAdmin".equals(user.getRoleType())) {
//            return "redirect:/";
            return "HomePage";
        } else if ("SuperAdmin".equals(user.getRoleType())) {
            return "HomePage";
        }
        model.addAttribute("error", "未知角色！");
        return "ManagementLogin";
    }

    // 退出登录
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        // 清除 Session 中的用户信息
        session.invalidate();
        return "redirect:/browse";
    }


}
