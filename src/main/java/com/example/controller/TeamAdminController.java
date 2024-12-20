package com.example.controller;

import com.example.model.Achievement;
import com.example.model.TeamAdministrator;
import com.example.model.User;
import com.example.service.AchievementService;
import com.example.service.AdministratorService;
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
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/teamAdmin")
public class TeamAdminController {

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private AdministratorService administratorService;

    /**
     * 团队管理员查看所有科研成果
     */
    @GetMapping("/achievements")
    public String viewAchievements(HttpSession session, Model model) {
        // 从 Session 中获取当前用户
        Object currentUser = session.getAttribute("currentUser");
        if (currentUser == null) {
            // 如果用户未登录，重定向到登录页面
            return "redirect:/login";
        }

        // 假设当前用户是 User 类型，获取 userID
        int adminID = ((User) currentUser).getUserID();  // adminID为外键，引用自User表

        // 查询团队管理员
        TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
        int teamID = teamAdministrator.getTeamID();

        // 获取团队所有成果列表
        List<Achievement> achievements = achievementService.getAchievementsByTeam(teamID);

        // 将成果列表传递给前端
        model.addAttribute("achievements", achievements);

        // 渲染科研成果管理页面
        return "TeamAdmin/achievement-management";
    }

    /**
     * 团队管理员新增科研成果
     */
    @PostMapping("/addAchievement/add")
    public String addAchievement(
            @RequestParam("title") String title,
            @RequestParam("category") String category,
            @RequestParam("abstractText") String abstractText,
            @RequestParam("contents") String contents,
            @RequestParam("attachmentFile") MultipartFile attachmentFile,
            @RequestParam("coverImage") MultipartFile coverImage,
            @RequestParam("creationTime") String creationTimeStr,
            HttpSession session,
            Model model
    ) {
        // 转换 creationTimeStr 为 Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return "TeamAdmin/achievement-management";

    }
}
