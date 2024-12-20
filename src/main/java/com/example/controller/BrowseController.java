package com.example.controller;

import com.example.model.Achievement;
import com.example.model.Article;
import com.example.model.Team;
import com.example.model.User;
import com.example.service.BrowseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class BrowseController {

    @Autowired
    private BrowseService browseService;

    // 信息浏览页面
    @GetMapping("/browse")
    public String browsePage(@RequestParam(value = "teammember", required = false) boolean isTeamMember,
                             @RequestParam(value = "member", required = false) boolean isMember,
                             HttpSession session,
                             Model model) {
        User currentUser = (User) session.getAttribute("currentUser"); // 从 Session 中获取当前用户

        // 将用户信息传递给前端
        model.addAttribute("isTeamMember", isTeamMember);
        model.addAttribute("isMember", isMember);
        model.addAttribute("user", currentUser);

        // 加载团队简介
        Team team = browseService.getTeamInfo();
        model.addAttribute("team", team);

        // 加载团队成员
        List<User> teamMembers = browseService.getTeamMembers();
        model.addAttribute("teamMembers", teamMembers);

        // 加载成果列表
        List<Achievement> softAchievements = browseService.getAchievementsByCategory("软著");
        List<Achievement> bookAchievements = browseService.getAchievementsByCategory("专著");
        List<Achievement> patentAchievements = browseService.getAchievementsByCategory("专利");
        List<Achievement> productAchievements = browseService.getAchievementsByCategory("产品");

        model.addAttribute("softAchievements", softAchievements);
        model.addAttribute("bookAchievements", bookAchievements);
        model.addAttribute("patentAchievements", patentAchievements);
        model.addAttribute("productAchievements", productAchievements);

        // 加载文章列表
        List<Article> articles = browseService.getArticles();
        model.addAttribute("articles", articles);


        return "browse"; // 返回信息浏览页面
    }


    // 团队成员详情
    @GetMapping("/member/details")
    public String memberDetails(@RequestParam("userID") int userID, Model model) {
        User member = browseService.getMemberDetails(userID);
        model.addAttribute("member", member);
        return "memberDetails"; // 返回成员详情页面
    }

    // 成果详情
    @GetMapping("/achievement/details")
    public String achievementDetails(@RequestParam("achievementID") int achievementID, Model model) {
        Achievement achievement = browseService.getAchievementDetails(achievementID);
        model.addAttribute("achievement", achievement);
        return "achievementDetails"; // 返回成果详情页面
    }

    // 文章详情
    @GetMapping("/article/details")
    public String articleDetails(@RequestParam("articleID") int articleID, Model model) {
        Article article = browseService.getArticleDetails(articleID);
        model.addAttribute("article", article);
        return "articleDetails"; // 返回文章详情页面
    }
}
