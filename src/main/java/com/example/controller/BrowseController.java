package com.example.controller;

import com.example.model.*;
import com.example.service.AchievementFileService;
import com.example.service.ArticleFileService;
import com.example.service.BrowseService;
import com.example.service.UserService;
import com.example.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class BrowseController {

    @Autowired
    private BrowseService browseService;

    @Autowired
    private AchievementFileService achievementFileService;

    @Autowired
    private ArticleFileService articleFileService;

    @Autowired
    private UserService userService;

    @Autowired
    private QuestionService questionService;

    // 信息浏览页面
    @GetMapping("/browse")
    public String browsePage(HttpSession session, Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        // 如果用户未登录，不强制报错，提供一个默认的空角色
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);

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

    @GetMapping("/team/members")
    public String viewTeamMembers(HttpSession session,Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        // 如果用户未登录，不强制报错，提供一个默认的空角色
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";

        // 加载团队简介
        Team team = browseService.getTeamInfo();
        model.addAttribute("team", team);

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);

        // 加载团队成员
        List<User> teamMembers = browseService.getTeamMembers();
        model.addAttribute("teamMembers", teamMembers);

        return "teamMembers"; // 返回团队成员 JSP 页面名称
    }




    // 团队成员详情
    @GetMapping("/member/details")
    public String memberDetails(@RequestParam("teamMembersID") int userID, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser"); // 从 Session 中获取当前用户
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";
        User member = browseService.getMemberDetails(userID);
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        model.addAttribute("member", member);
        return "TeamAdmin/memberDetails"; // 返回成员详情页面
    }

    // 团队成员详情
    @GetMapping("/memberManage/details")
    public String ManageMemberDetails(@RequestParam("teamMembersID") int userID, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser"); // 从 Session 中获取当前用户
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";
        User member = browseService.getMemberDetails(userID);
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        model.addAttribute("member", member);
        return "TeamAdmin/ManageMemberDetails"; // 返回成员详情页面
    }


    // 成果详情
    @GetMapping("/achievement/details")
    public String achievementDetails(@RequestParam("achievementID") int achievementID, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser"); // 从 Session 中获取当前用户
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";
        Achievement achievement = browseService.getAchievementDetails(achievementID);
        List<AchievementFile> files = achievementFileService.getFilesByAchievementId(achievementID);
        User user = userService.findById(achievement.getTeamAdminID());
        model.addAttribute("publisherName", user.getName());
        model.addAttribute("files", files);
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        model.addAttribute("achievement", achievement);

        // 根据 achievementID 和 category 查询相关评论
        List<Question> comments = questionService.getCommentsByAchievement(achievementID, achievement.getCategory());
        // 过滤掉 status 为 -1 的评论
        comments = comments.stream()
                .filter(comment -> comment.getStatus() != -1)
                .collect(Collectors.toList());

        // 为每条评论设置 userName 和 teamAdminName
        comments.forEach(comment -> {
            User user = userService.findById(comment.getUserID());
            User admin = userService.findById(comment.getTeamAdminID());
            if (user != null) {
                comment.setUserName(user.getUsername());
                if(admin!=null) {
                    comment.setTeamAdminName(admin.getUsername());
                }
            }
        });

        model.addAttribute("comments", comments);

        return "achievementDetails"; // 返回成果详情页面
    }

    // 文章详情
    @GetMapping("/article/details")
    public String articleDetails(@RequestParam("articleID") int articleID, HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser"); // 从 Session 中获取当前用户
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";
        Article article = browseService.getArticleDetails(articleID);
        List<ArticleFile> files = articleFileService.getFilesByArticleId(articleID);
        User user = userService.findById(article.getTeamAdminID());
        model.addAttribute("publisherName", user.getName());
        model.addAttribute("files", files);
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        model.addAttribute("article", article);

        // 根据 articleID 和 category 查询相关评论
        List<Question> comments = questionService.getCommentsByArticle(articleID, article.getCategory());
        // 过滤掉 status 为 -1 的评论
        comments = comments.stream()
                .filter(comment -> comment.getStatus() != -1)
                .collect(Collectors.toList());

        // 为每条评论设置 userName 和 teamAdminName
        comments.forEach(comment -> {
            User user = userService.findById(comment.getUserID());
            User admin = userService.findById(comment.getTeamAdminID());
            if (user != null) {
                comment.setUserName(user.getUsername());
                if(admin!=null) {
                comment.setTeamAdminName(admin.getUsername());
                }
            }
        });

        model.addAttribute("comments", comments);

        return "articleDetails"; // 返回文章详情页面
    }

    @GetMapping("/achievements/{category}")
    public String viewAchievementsByCategory(@PathVariable("category") String category,
                                             @RequestParam(value = "year", required = false) String year,
                                             @RequestParam(value = "sortOrder", defaultValue = "desc") String sortOrder,
                                             HttpSession session,
                                             Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        // 如果用户未登录，不强制报错，提供一个默认的空角色
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        // 将英文类别映射到中文
        String categoryName = getCategoryName(category);

        // 根据选择的年份和排序方式获取成果
        boolean ascending = "asc".equalsIgnoreCase(sortOrder);

        // 获取该分类的所有成果，按时间排序
        List<Achievement> achievements = browseService.getAchievementsByCategorySorted(categoryName, year, ascending);

        // 获取所有年份（用于筛选）
        List<String> years = browseService.getAllAchievementYears(categoryName);

        // 将成果列表和分类名称传递到 JSP 页面
        model.addAttribute("achievements", achievements);
        model.addAttribute("category", category);
        model.addAttribute("years", years);
        model.addAttribute("selectedYear", year);
        model.addAttribute("selectedSortOrder", sortOrder);
        model.addAttribute("categoryname", categoryName); // 传递中文分类名称
        return "achievements"; // 返回统一的 JSP 页面
    }

    // 将英文类别映射为中文
    private String getCategoryName(String category) {
        switch (category.toLowerCase()) {
            case "soft":
                return "软著";
            case "book":
                return "专著";
            case "patent":
                return "专利";
            case "product":
                return "产品";
            default:
                return "未知";
        }
    }

    // 查看所有文章并支持筛选和排序
    @GetMapping("/articles")
    public String viewArticles(@RequestParam(value = "year", required = false) String year,
                               @RequestParam(value = "category", required = false) String category,
                               @RequestParam(value = "sortOrder", defaultValue = "desc") String sortOrder,
                               HttpSession session,
                               Model model) {
        // 从 Session 中获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        // 如果用户未登录，不强制报错，提供一个默认的空角色
        String userRoleType = (currentUser != null) ? currentUser.getRoleType() : "Guest";

        // 将用户信息传递给前端
        model.addAttribute("user", currentUser);
        model.addAttribute("userRoleType", userRoleType);
        boolean ascending = "asc".equalsIgnoreCase(sortOrder);

        // 获取筛选后的文章，并按时间排序
        List<Article> articles = browseService.getArticlesSortedByDate(year, category, ascending);

        // 获取筛选条件
        List<String> years = browseService.getAllArticleYears();
        List<String> categories = browseService.getAllArticleCategories();

        // 将文章列表和筛选条件传递到前端
        model.addAttribute("articles", articles);
        model.addAttribute("years", years);
        model.addAttribute("categories", categories);
        model.addAttribute("selectedYear", year);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("selectedSortOrder", sortOrder);

        return "articles"; // 返回文章列表页面
    }

}
