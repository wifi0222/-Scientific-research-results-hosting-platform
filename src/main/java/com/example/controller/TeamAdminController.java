package com.example.controller;

import com.example.model.Achievement;
import com.example.model.TeamAdministrator;
import com.example.model.User;
import com.example.service.AchievementService;
import com.example.service.AdministratorService;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.model.*;
import com.example.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Array;
import java.text.ParseException;
import java.util.*;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/teamAdmin")
public class TeamAdminController {
    @Autowired
    private TeamService teamService;

    @Autowired
    private UserService userService;

    @Autowired
    private RegistrationService registrationService;

    @Autowired
    private MemberViewService memberViewService;

    @Autowired
    private ISendMailService sendMailService;

    @Autowired
    private DeactivationService deactivationService;

    @Autowired
    private AchievementService achievementService;

    @Autowired
    private AdministratorService administratorService;

    @Autowired
    private AchievementFileService achievementFileService;

    @Autowired
    private ArticleFileService articleFileService;

    @Autowired
    private ArticleService articleService;

    //跳转到团队基本信息维护
    @RequestMapping("/TeamManage/Info")
    public String TeamInfo(Model model, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }


        Team team = teamService.getTeam();
        model.addAttribute("team", team);
        return "TeamAdmin/TeamInfoManage";
    }

    //更新团队信息
    @RequestMapping("/TeamManage/Info/edit")
    public String TeamInfoEdit(Model model, @ModelAttribute Team team, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        teamService.updateTeamInfo(team);
        model.addAttribute("message", "修改团队信息成功");
        return "index";
    }

    //跳转到团队成员管理
    @RequestMapping("/TeamManage/Member")
    public String TeamMember(Model model, @RequestParam(required = false) String information, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }
        List<User> members = userService.findAllTeamMember();
        model.addAttribute("members", members);
        model.addAttribute("information", information);
        return "TeamAdmin/TeamMemberManage";
    }

    //添加团队成员
    @RequestMapping("/TeamManage/Member/add")
    public String addTeamMember(RedirectAttributes redirectAttributes, @ModelAttribute User TeamMember, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        System.out.println(TeamMember);
        String information = "添加团队成员成功";
        if (userService.findByUserName(TeamMember.getUsername()) != null) {
            information = "用户名已存在，添加失败";
        } else {
            userService.addTeamMember(TeamMember);
        }
        redirectAttributes.addAttribute("information", information);
        return "redirect:/teamAdmin/TeamManage/Member";
    }

    //跳转编辑团队成员信息
    @RequestMapping("/ToChangeTeamMember")
    public String ToChangeTeamMember(Model model, @RequestParam("userID") int userID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        User user = userService.findById(userID);
        model.addAttribute("user", user);
        return "TeamAdmin/ChangeTeamMember";
    }

    //编辑团队成员信息
    @PostMapping("/TeamManage/Member/edit")
    public String TeamMemberEdit(Model model, @ModelAttribute User TeamMember, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        System.out.println(TeamMember);
        userService.updateTeamMember(TeamMember);
        return "redirect:/teamAdmin/TeamManage/Member";
    }

    //跳转用户审核
    @GetMapping("ToMemberInfoReview")
    public String MemberInfoReview(Model model, String message, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        List<MemberReview> memberReviews = memberViewService.getMemberReviews();
        model.addAttribute("memberReviews", memberReviews);
        if (message != null) {
            model.addAttribute("message", message);
        }
        return "TeamAdmin/MemberReviewInfo";
    }

    //处理审核
    @GetMapping("/TeamManage/Member/review")
    public String SubmitMemberReview(RedirectAttributes redirectAttributes, @RequestParam("memberID") int memberID, @RequestParam("status") int status,
                                     @RequestParam(required = false) String refuseReason, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        if (status == 1) {
            //更新审核结果和用户的信息
            MemberReview memberReview = memberViewService.findByMemberID(memberID);
//            memberViewService.updateSuccessResult(memberID);
            userService.updateTeamMemberInfo(memberReview);
            memberViewService.deleteSuccess(memberID);
        } else {
            //更新审核结果和拒绝原因
            memberViewService.updateFailResult(memberID, refuseReason);
        }
        redirectAttributes.addAttribute("message", "审核成功");
        return "redirect:/teamAdmin/ToMemberInfoReview";
    }

    //用户修改信息详情
    @RequestMapping("/TeamManage/Member/ReviewDetail")
    public String MemberReviewDetail(Model model, @RequestParam("memberID") int memberID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        MemberReview memberReview = memberViewService.findByMemberID(memberID);
        model.addAttribute("member", memberReview);
        return "TeamAdmin/MemberReviewDetail";
    }


    //批量通过审核
    @RequestMapping("/TeamManage/Member/BatchReview")
    @ResponseBody
    public Map<String, Object> ReviewBatch(@RequestBody Map<String, List<Integer>> requestData,
                                                         HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        }

        List<Integer> memberIds = requestData.get("memberIds");
        System.out.println("Received member IDs: " + memberIds); // 打印接收到的用户ID列表
        if (memberIds == null || memberIds.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的成员");
            return response;
        }

        // 批量执行
        try {
            for (Integer memberId : memberIds) {
                MemberReview memberReview = memberViewService.findByMemberID(memberId);
                userService.updateTeamMemberInfo(memberReview);
                memberViewService.deleteSuccess(memberId);
            }
            response.put("success", true);
            response.put("message", "设置成功");
        } catch (Exception e) {
            e.printStackTrace();  // 打印堆栈信息
            response.put("success", false);
            response.put("message", "设置失败：" + e.getMessage());
        }
        return response;
    }


    //跳转到用户管理模块
    @GetMapping("ToUserRegisterManage")
    public String ToTeamUserManage(Model model, @RequestParam(required = false) String message, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        //判断是否有权限
        if(administratorService.getUserManageAdministrator(currentUser.getUserID())==false){
            return "redirect:/NoAdministrator.jsp";
        }

        List<RegistrationReview> users = registrationService.getAllRegistrationReviews();
        model.addAttribute("users", users);
        model.addAttribute("message", message);
        return "TeamAdmin/UserRegisterManage";
    }

    //处理审核
    @GetMapping("/RegisterReview")
    public String SubmitRegisterReview(RedirectAttributes redirectAttributes, @RequestParam("username") String username, @RequestParam("status") int status,
                                       @RequestParam(required = false) String refuseReason, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }
        //判断是否有权限
        if(administratorService.getUserManageAdministrator(currentUser.getUserID())==false){
            return "redirect:/NoAdministrator.jsp";
        }

        System.out.println("获得的信息" + username);
        RegistrationReview registrationReview = registrationService.getRegisterByusername(username);
        String sendMessage; //通过邮件发送的通知
        String sendEmail = registrationReview.getEmail(); //发送邮件的邮箱
        if (status == 1) {
            //通过审核---插入用户表里面，更新状态，发送通知
            sendMessage = "您的注册申请审核已通过,请及时登录";
            userService.addNewUser(registrationReview);
            registrationService.updateSuccessResult(username);
        } else {
            //审核失败---更新状态，发送通知
            sendMessage = "您的注册申请审核未通过,请重新提交\n" + refuseReason;
            registrationService.updateFailResult(username, refuseReason);
        }
        sendMailService.sendMessageEmail(sendEmail, sendMessage);
        redirectAttributes.addAttribute("message", "审核成功");
        return "redirect:/teamAdmin/ToUserRegisterManage";
    }

    //批量通过审核
    @RequestMapping("/BatchRegisterReview")
    @ResponseBody
    public Map<String, Object> RegisterReviewBatch(@RequestBody Map<String, List<String>> requestData,
                                           HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        }

        List<String> userNames = requestData.get("userNames");
        System.out.println("Received user Names: " + userNames); // 打印接收到的用户ID列表
        if (userNames == null || userNames.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的成员");
            return response;
        }

        // 批量执行
        try {
            for (String username : userNames) {
                RegistrationReview registrationReview = registrationService.getRegisterByusername(username);
                String sendMessage; //通过邮件发送的通知
                String sendEmail = registrationReview.getEmail(); //发送邮件的邮箱
                //通过审核---插入用户表里面，更新状态，发送通知
                sendMessage = "您的注册申请审核已通过,请及时登录";
                userService.addNewUser(registrationReview);
                registrationService.updateSuccessResult(username);
                sendMailService.sendMessageEmail(sendEmail, sendMessage);
            }
            response.put("success", true);
            response.put("message", "设置成功");
        } catch (Exception e) {
            e.printStackTrace();  // 打印堆栈信息
            response.put("success", false);
            response.put("message", "设置失败：" + e.getMessage());
        }
        return response;
    }

    /**
     * 团队管理员查看所有科研成果
     * type=0，处理科研成果；type=1.处理文章
     */
    @GetMapping("/achievements")
    public String viewAchievements(@RequestParam("type") int type, HttpSession session, Model model) {
        // 从 Session 中获取当前用户
        Object currentUser = session.getAttribute("currentUser");
        if (currentUser == null) {
            // 如果用户未登录，重定向到登录页面
            return "redirect:/login";
        }

        //        // 如果存在多个团队，这样获取团队管理员所属的团队的ID
        //        int adminID = ((User) currentUser).getUserID();  // adminID为外键，引用自User表
        //
        //        // 查询团队管理员
        //        TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
        //        int teamID = teamAdministrator.getTeamID();

        int teamID = 1;

        // 处理科研成果
        if (type == 0) {
            // 定义类别的排序优先级
            List<String> categoryOrder = Arrays.asList("专著", "专利", "软著", "产品");

            // 获取团队所有成果列表
            List<Achievement> achievements = achievementService.getAchievementsByTeam(teamID);

            // 排序成果列表
            achievements.sort((a1, a2) -> {
                // 按类别顺序排序
                int categoryComparison = Integer.compare(categoryOrder.indexOf(a1.getCategory()), categoryOrder.indexOf(a2.getCategory()));
                if (categoryComparison != 0) {
                    return categoryComparison; // 如果类别不同，按类别排序
                }
                // 如果类别相同，按 ID 升序排序
                return Integer.compare(a1.getAchievementID(), a2.getAchievementID());
            });

            // 创建排序后的 Map，用 LinkedHashMap 保证顺序
            Map<Achievement, List<AchievementFile>> achievementMap = new LinkedHashMap<>();

            for (Achievement a : achievements) {
                // 获取每个成果的附件和图片
                List<AchievementFile> achievementFiles = achievementFileService.getFilesByAchievementId(a.getAchievementID());
                achievementMap.put(a, achievementFiles);
            }

            model.addAttribute("achievementMap", achievementMap);
            // 渲染科研成果管理页面
            return "TeamAdmin/achievement-management";
        } else if (type == 1) {
            // 定义类别的排序优先级
            List<String> categoryOrder = Arrays.asList("SCI", "EI", "核心");

            // 获取团队所有成果列表
            List<Article> articles = articleService.getArticlesByTeam(teamID);

            // 排序成果列表
            articles.sort((a1, a2) -> {
                // 按类别顺序排序
                int categoryComparison = Integer.compare(categoryOrder.indexOf(a1.getCategory()), categoryOrder.indexOf(a2.getCategory()));
                if (categoryComparison != 0) {
                    return categoryComparison; // 如果类别不同，按类别排序
                }
                // 如果类别相同，按 ID 升序排序
                return Integer.compare(a1.getArticleID(), a2.getArticleID());
            });

            // 创建排序后的 Map，用 LinkedHashMap 保证顺序
            Map<Article, List<ArticleFile>> articleListMap = new LinkedHashMap<>();

            for (Article a : articles) {
                // 获取每个成果的附件和图片
                List<ArticleFile> articleFiles = articleFileService.getFilesByArticleId(a.getArticleID());
                articleListMap.put(a, articleFiles);
            }

            model.addAttribute("articleListMap", articleListMap);
            // 渲染科研成果管理页面
            return "TeamAdmin/article-management";
        }

        // 返回error页面
        return "TeamAdmin/error";
    }

    /**
     * 团队管理员新增科研成果
     */
    @PostMapping("/achievements/add")
    public String addAchievement(@RequestParam("title") String title, @RequestParam("category") String category, @RequestParam("abstractContent") String abstractContent, @RequestParam("contents") String contents, @RequestParam("attachmentFile") MultipartFile attachmentFile, @RequestParam("coverImage") MultipartFile coverImage, @RequestParam("creationTime") String creationTimeStr, @RequestParam("type") int type, HttpSession session, Model model) {
        // 从 Session 中获取当前用户
        Object currentUser = session.getAttribute("currentUser");
        if (currentUser == null) {
            // 如果用户未登录，重定向到登录页面
            return "redirect:/login";
        }

        // 假设当前用户是 User 类型，获取 userID
        int adminID = ((User) currentUser).getUserID();  // adminID为外键，引用自User表

        if (type == 0) {
            // 判断该团队管理员是否具有新增科研成果的权限
            TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
            if (!teamAdministrator.isPublishAchievement()) {
                model.addAttribute("error", "您没有新增科研成果的权限！请联系超级用户管理员");
                return "/TeamAdmin/error";
            }

            // 定义日期格式模式
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

            Date creationTime = null;
            try {
                creationTime = sdf.parse(creationTimeStr);
            } catch (ParseException e) {
                model.addAttribute("error", "日期格式错误");
                return "/TeamAdmin/error";
            }

            // 目前只有一个团队
            Integer teamID = 1;

            // 创建 Achievement 对象并设置属性
            Achievement achievement = new Achievement();
            achievement.setTitle(title);
            achievement.setCategory(category);
            achievement.setAbstractContent(abstractContent);
            achievement.setContents(contents);
            achievement.setCreationTime(creationTime);
            achievement.setTeamID(teamID);
            achievement.setStatus(0); // 默认状态为待审核
            achievement.setViewStatus(0); // 默认不公开

            try {
                // 调用服务层插入成果
                Achievement savedAchievement = achievementService.insertAchievement(achievement);
                if (savedAchievement != null && savedAchievement.getAchievementID() > 0) {
                    int achievementID = savedAchievement.getAchievementID(); // 获取生成的 ID

                    // 附件文件
                    String attachmentName = null;
                    String attachmentPath = null;

                    if (attachmentFile != null && !attachmentFile.isEmpty()) {
                        attachmentName = attachmentFile.getOriginalFilename();
                        attachmentPath = saveFile(attachmentFile, "科研成果附件\\", 0);
                        // 创建 AchievementFile 对象并设置属性
                        AchievementFile achievementFile = new AchievementFile();
                        achievementFile.setAchievementID(achievementID);
                        achievementFile.setType(0);     // 附件
                        achievementFile.setFileName(attachmentName);
                        achievementFile.setFilePath(attachmentPath);
                        achievementFile.setUploadTime(new Date());  // 当前时间

                        achievementFileService.insertAchievementFile(achievementFile);
                    }

                    // 图片，本地文件夹地址
                    String coverImageName = null;
                    String coverImagePath = null;

                    if (coverImage != null && !coverImage.isEmpty()) {
                        coverImageName = coverImage.getOriginalFilename();
                        coverImagePath = saveFile(coverImage, "科研成果图片\\", 1);
                        // 创建 AchievementFile 对象并设置属性
                        AchievementFile achievementImage = new AchievementFile();
                        achievementImage.setAchievementID(achievementID);
                        achievementImage.setType(1);     // 图片
                        achievementImage.setFileName(coverImageName);
                        achievementImage.setFilePath(coverImagePath);
                        achievementImage.setUploadTime(new Date());  // 当前时间

                        achievementFileService.insertAchievementFile(achievementImage);
                    }

                } else {
                    model.addAttribute("error", "成果添加失败，请重试。");
                }
            } catch (Exception e) {
                model.addAttribute("error", "成果添加过程中发生错误，请重试。");
                e.printStackTrace();
                return "/TeamAdmin/error";
            }
            // 加/ 表示从根目录开始，否则会从当前路径拼接
            return "redirect:/teamAdmin/achievements?type=0";
        } else if (type == 1) {
//            // 判断该团队管理员是否具有新增科研成果的权限
//            TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
//            if (!teamAdministrator.isPublishPermission()) {
//                model.addAttribute("error", "您没有新增科研成果的权限！请联系超级用户管理员");
//                return "/TeamAdmin/error";
//            }

            // 定义日期格式模式
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

            Date publishDate = null;
            try {
                publishDate = sdf.parse(creationTimeStr);
            } catch (ParseException e) {
                model.addAttribute("error", "日期格式错误");
                return "/TeamAdmin/error";
            }

            // 目前只有一个团队
            Integer teamID = 1;

            // 创建 Article 对象并设置属性
            Article article = new Article();
            article.setTitle(title);
            article.setCategory(category);
            article.setAbstractContent(abstractContent);
            article.setContents(contents);
            article.setPublishDate(publishDate);
            article.setTeamID(teamID);
            article.setStatus(0); // 默认状态为待审核
            article.setViewStatus(0); // 默认不公开

            try {
                // 调用服务层插入文章
                Article savedArticle = articleService.insertArticle(article);
                if (savedArticle != null && savedArticle.getArticleID() > 0) {
                    int articleID = savedArticle.getArticleID(); // 获取生成的 ID

                    // 附件文件
                    String attachmentName = null;
                    String attachmentPath = null;

                    if (attachmentFile != null && !attachmentFile.isEmpty()) {
                        attachmentName = attachmentFile.getOriginalFilename();
                        attachmentPath = saveFile(attachmentFile, "文章附件\\", 0);
                        // 创建 ArticleFile 对象并设置属性
                        ArticleFile articleFile = new ArticleFile();
                        articleFile.setArticleID(articleID);
                        articleFile.setType(0);     // 附件
                        articleFile.setFileName(attachmentName);
                        articleFile.setFilePath(attachmentPath);
                        articleFile.setUploadTime(new Date());  // 当前时间

                        articleFileService.insertArticleFile(articleFile);
                    }

                    // 封面图片
                    String coverImageName = null;
                    String coverImagePath = null;

                    if (coverImage != null && !coverImage.isEmpty()) {
                        coverImageName = coverImage.getOriginalFilename();
                        coverImagePath = saveFile(coverImage, "文章图片\\", 1);
                        // 创建 ArticleFile 对象并设置属性
                        ArticleFile articleImage = new ArticleFile();
                        articleImage.setArticleID(articleID);
                        articleImage.setType(1);     // 图片
                        articleImage.setFileName(coverImageName);
                        articleImage.setFilePath(coverImagePath);
                        articleImage.setUploadTime(new Date());  // 当前时间

                        articleFileService.insertArticleFile(articleImage);
                    }

                } else {
                    model.addAttribute("error", "文章添加失败，请重试。");
                }
            } catch (Exception e) {
                model.addAttribute("error", "文章添加过程中发生错误，请重试。");
                e.printStackTrace();
                return "/TeamAdmin/error";
            }
            // 加/ 表示从根目录开始，否则会从当前路径拼接
            return "redirect:/teamAdmin/achievements?type=1";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    // 文件保存方法：文件；文件上传的目录
    private String saveFile(MultipartFile file, String uploadDir, int type) throws Exception {

        String location = "C:\\Users\\zwb\\Desktop\\JavaWeb课设\\";

        if (file.isEmpty()) {
            return null;
        }
        // 生成一个唯一的时间戳，防止文件名冲突
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        File dest = new File(location + uploadDir + fileName);
        // 确保上传目录存在，不存在，则创建
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        //  将上传的文件保存到指定的目录
        file.transferTo(dest);
//        return dest.getAbsolutePath();
        if (type == 0) {
            // 附件，静态资源配置
            return "uploads\\" + uploadDir + fileName;
        } else if (type == 1) {
            // 图片，本地绝对地址，control解析
            return location + uploadDir + fileName;
        }
        return null;
    }

    /**
     * 显示修改科研成果的表单
     */
    @GetMapping("/achievements/edit")
    public String showEditAchievementForm(@RequestParam("id") int id, @RequestParam("type") int type, Model model) {

        if (type == 0) {
            // 获取指定ID的成果
            Achievement achievement = achievementService.getAchievementById(id);
            if (achievement == null) {
                model.addAttribute("error", "未找到指定的科研成果。");
                return "/TeamAdmin/error";
            }

            // 获取该成果的附件和图片
            List<AchievementFile> achievementFiles = achievementFileService.getFilesByAchievementId(id);

            // 将数据传递给前端
            model.addAttribute("achievement", achievement);
            model.addAttribute("achievementFiles", achievementFiles);

            // 渲染修改科研成果的页面
            return "/TeamAdmin/editAchievement";
        } else if (type == 1) {
            // 获取指定ID的文章
            Article article = articleService.getArticleById(id);
            if (article == null) {
                model.addAttribute("error", "未找到指定的文章。");
                return "/TeamAdmin/error";
            }

            // 获取该文章的附件和图片
            List<ArticleFile> articleFiles = articleFileService.getFilesByArticleId(id);

            // 将数据传递给前端
            model.addAttribute("article", article);
            model.addAttribute("articleFiles", articleFiles);

            // 渲染修改文章的页面
            return "/TeamAdmin/editArticle";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    /**
     * 处理修改科研成果的表单提交
     */
    @PostMapping("/achievements/edit/update")
    public String updateAchievement(@RequestParam("id") int id, @RequestParam("title") String title, @RequestParam("category") String category, @RequestParam("abstractContent") String abstractContent, @RequestParam("contents") String contents, @RequestParam("attachmentFile") MultipartFile attachmentFile, @RequestParam("coverImage") MultipartFile coverImage, @RequestParam("creationTime") String creationTimeStr, @RequestParam("type") int type, HttpSession session, Model model) {
        // 定义日期格式模式
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Date creationTime = null;
        try {
            creationTime = sdf.parse(creationTimeStr);
        } catch (ParseException e) {
            model.addAttribute("error", "日期格式错误");
            return "/TeamAdmin/error";
        }

        // 目前只有一个团队
        Integer teamID = 1;

        if (type == 0) {
            // 获取现有的成果
            Achievement achievement = achievementService.getAchievementById(id);
            if (achievement == null) {
                model.addAttribute("error", "未找到指定的科研成果。");
                return "/TeamAdmin/error";
            }

            // 更新 Achievement 对象的属性
            achievement.setTitle(title);
            achievement.setCategory(category);
            achievement.setAbstractContent(abstractContent);
            achievement.setContents(contents);
            achievement.setCreationTime(creationTime);
            achievement.setTeamID(teamID);
            achievement.setStatus(0); // 默认状态为待审核
            achievement.setViewStatus(0); // 默认不公开

            try {
                // 调用服务层更新成果
                int success = achievementService.updateAchievement(achievement);
                if (success == 1) {
                    // 处理附件文件（如果有上传新的附件）
                    if (attachmentFile != null && !attachmentFile.isEmpty()) {
                        String attachmentName = attachmentFile.getOriginalFilename();
                        String attachmentPath = saveFile(attachmentFile, "科研成果附件\\", 0);
                        // 创建 AchievementFile 对象并设置属性
                        AchievementFile achievementFile = new AchievementFile();
                        achievementFile.setAchievementID(id);
                        achievementFile.setType(0); // 附件
                        achievementFile.setFileName(attachmentName);
                        achievementFile.setFilePath(attachmentPath);
                        achievementFile.setUploadTime(new Date());

                        // 保存附件文件
                        achievementFileService.insertAchievementFile(achievementFile);
                    }

                    // 处理封面图片（如果有上传新的图片）
                    if (coverImage != null && !coverImage.isEmpty()) {
                        String coverImageName = coverImage.getOriginalFilename();
                        String coverImagePath = saveFile(coverImage, "科研成果图片\\", 1);
                        // 创建 AchievementFile 对象并设置属性
                        AchievementFile achievementImage = new AchievementFile();
                        achievementImage.setAchievementID(id);
                        achievementImage.setType(1); // 图片
                        achievementImage.setFileName(coverImageName);
                        achievementImage.setFilePath(coverImagePath);
                        achievementImage.setUploadTime(new Date());

                        // 保存封面图片
                        achievementFileService.insertAchievementFile(achievementImage);
                    }
                } else {
                    model.addAttribute("error", "成果添加失败，请重试。");
                }
            } catch (Exception e) {
                model.addAttribute("error", "编辑成果过程中发生错误，请重试。");
                e.printStackTrace();
                return "TeamAdmin/error";
            }

            // 重定向到成果的编辑页面
            return "redirect:/teamAdmin/achievements/edit?id=" + id + "&type=0";
        } else if (type == 1) {
            // 获取现有的文章
            Article article = articleService.getArticleById(id);
            if (article == null) {
                model.addAttribute("error", "未找到指定的文章。");
                return "/TeamAdmin/error";
            }

            // 更新 Article 对象的属性
            article.setTitle(title);
            article.setCategory(category);
            article.setAbstractContent(abstractContent);
            article.setContents(contents);
            article.setPublishDate(creationTime);
            article.setTeamID(teamID);
            article.setStatus(0); // 默认状态为待审核
            article.setViewStatus(0); // 默认不公开

            try {
                // 调用服务层更新文章
                int success = articleService.updateArticle(article);
                if (success == 1) {
                    // 处理附件文件（如果有上传新的附件）
                    if (attachmentFile != null && !attachmentFile.isEmpty()) {
                        String attachmentName = attachmentFile.getOriginalFilename();
                        String attachmentPath = saveFile(attachmentFile, "文章附件\\", 0);
                        // 创建 ArticleFile 对象并设置属性
                        ArticleFile articleFile = new ArticleFile();
                        articleFile.setArticleID(id);
                        articleFile.setType(0); // 附件
                        articleFile.setFileName(attachmentName);
                        articleFile.setFilePath(attachmentPath);
                        articleFile.setUploadTime(new Date());

                        // 保存附件文件
                        articleFileService.insertArticleFile(articleFile);
                    }

                    // 处理封面图片（如果有上传新的图片）
                    if (coverImage != null && !coverImage.isEmpty()) {
                        String coverImageName = coverImage.getOriginalFilename();
                        String coverImagePath = saveFile(coverImage, "文章图片\\", 1);
                        // 创建 ArticleFile 对象并设置属
                        ArticleFile articleImage = new ArticleFile();
                        articleImage.setArticleID(id);
                        articleImage.setType(1); // 图片
                        articleImage.setFileName(coverImageName);
                        articleImage.setFilePath(coverImagePath);
                        articleImage.setUploadTime(new Date());

                        // 保存封面图片
                        articleFileService.insertArticleFile(articleImage);
                    }
                } else {
                    model.addAttribute("error", "文章更新失败，请重试。");
                }
            } catch (Exception e) {
                model.addAttribute("error", "编辑文章过程中发生错误，请重试。");
                e.printStackTrace();
                return "/TeamAdmin/error";
            }

            // 重定向到文章的编辑页面
            return "redirect:/teamAdmin/achievements/edit?id=" + id + "&type=1";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    /**
     * 处理单独删除科研成果
     */
    @GetMapping("/achievements/delete")
    public String deleteAchievement(@RequestParam("id") int id, @RequestParam("type") int type, Model model, HttpSession session) {
        // 从 Session 中获取当前用户
        Object currentUser = session.getAttribute("currentUser");
        if (currentUser == null) {
            // 如果用户未登录，重定向到登录页面
            return "redirect:/login";
        }

        // 假设当前用户是 User 类型，获取 userID
        int adminID = ((User) currentUser).getUserID();  // adminID为外键，引用自User表

        if (type == 0) {
            // 判断该团队管理员是否具有删除科研成果的权限
            TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
            if (!teamAdministrator.isDeleteAchievement()) {
                model.addAttribute("error", "您没有删除科研成果的权限！请联系超级用户管理员");
                return "/TeamAdmin/error";
            }

            // 目前只有一个团队
            Integer teamID = 1;

            // 获取现有的成果
            Achievement achievement = achievementService.getAchievementById(id);
            if (achievement == null) {
                model.addAttribute("error", "未找到指定的科研成果。");
                return "/TeamAdmin/error";
            }

            // 获取该成果的附件和图片
            List<AchievementFile> achievementFiles = achievementFileService.getFilesByAchievementId(id);

            // 删除该成果的所有附件和图片
            for (AchievementFile file : achievementFiles) {
                // 删除本地的附件/图片
                deleteLocationFile(file.getFilePath(), file.getType());

                // 从数据库中删除 AchievementFile 记录
                achievementFileService.deleteAchievementFile(file.getFileID());
            }

            // 从数据库中删除 Achievement 记录
            achievementService.deleteAchievement(id);

            // 重定向到成果展示页面
            return "redirect:/teamAdmin/achievements?type=0";
        } else if (type == 1) {
//            // 判断该团队管理员是否具有删除文章的权限
//            TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
//            if (!teamAdministrator.isDeletePermission()) {
//                model.addAttribute("error", "您没有删除文章的权限！请联系超级用户管理员");
//                return "/TeamAdmin/error";
//            }

            // 目前只有一个团队
            Integer teamID = 1;

            // 获取现有的文章
            Article article = articleService.getArticleById(id);
            if (article == null) {
                model.addAttribute("error", "未找到指定的文章。");
                return "/TeamAdmin/error";
            }

            // 获取该文章的附件和图片
            List<ArticleFile> articleFiles = articleFileService.getFilesByArticleId(id);

            // 删除该文章的所有附件和图片
            for (ArticleFile file : articleFiles) {
                // 删除本地的附件/图片
                deleteLocationFile(file.getFilePath(), file.getType());

                // 从数据库中删除 ArticleFile 记录
                articleFileService.deleteArticleFile(file.getFileID());
            }

            // 从数据库中删除 Article 记录
            articleService.deleteArticle(id);

            // 重定向到文章展示页面
            return "redirect:/teamAdmin/achievements?type=1";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    /**
     * 处理批量删除科研成果
     */
    @GetMapping("/achievements/batchDelete")
    public String batchDeleteAchievement(@RequestParam("ids") List<Integer> selectedIds, @RequestParam("type") int type, Model model, HttpSession session) {
        // 从 Session 中获取当前用户
        Object currentUser = session.getAttribute("currentUser");
        if (currentUser == null) {
            // 如果用户未登录，重定向到登录页面
            return "redirect:/login";
        }

        // 假设当前用户是 User 类型，获取 userID
        int adminID = ((User) currentUser).getUserID();  // adminID为外键，引用自User表

        // 目前只有一个团队
        Integer teamID = 1;

        if (type == 0) {
            // 判断该团队管理员是否具有删除科研成果的权限
            TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
            if (!teamAdministrator.isDeleteAchievement()) {
                model.addAttribute("error", "您没有删除科研成果的权限！请联系超级用户管理员");
                return "/TeamAdmin/error";
            }


            for (int id : selectedIds) {
                // 获取现有的成果
                Achievement achievement = achievementService.getAchievementById(id);
                if (achievement == null) {
                    model.addAttribute("error", "未找到指定的科研成果。");
                    return "/TeamAdmin/error";
                }

                // 获取该成果的附件和图片
                List<AchievementFile> achievementFiles = achievementFileService.getFilesByAchievementId(id);

                // 删除该成果的所有附件和图片
                for (AchievementFile file : achievementFiles) {
                    // 删除本地的附件/图片
                    deleteLocationFile(file.getFilePath(), file.getType());

                    // 从数据库中删除 AchievementFile 记录
                    achievementFileService.deleteAchievementFile(file.getFileID());
                }

                // 从数据库中删除 Achievement 记录
                achievementService.deleteAchievement(id);
            }

            // 重定向到成果展示页面
            return "redirect:/teamAdmin/achievements?type=0";
        } else if (type == 1) {
//            // 判断该团队管理员是否具有删除文章的权限
//            TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
//            if (!teamAdministrator.isDeletePermission()) {
//                model.addAttribute("error", "您没有删除文章的权限！请联系超级用户管理员");
//                return "/TeamAdmin/error";
//            }

            for (int id : selectedIds) {
                // 获取现有的文章
                Article article = articleService.getArticleById(id);
                if (article == null) {
                    model.addAttribute("error", "未找到指定的文章。");
                    return "/TeamAdmin/error";
                }

                // 获取该文章的附件和图片
                List<ArticleFile> articleFiles = articleFileService.getFilesByArticleId(id);

                // 删除该文章的所有附件和图片
                for (ArticleFile file : articleFiles) {
                    // 删除本地的附件/图片
                    deleteLocationFile(file.getFilePath(), file.getType());

                    // 从数据库中删除 ArticleFile 记录
                    articleFileService.deleteArticleFile(file.getFileID());
                }

                // 从数据库中删除 Article 记录
                articleService.deleteArticle(id);
            }
            // 重定向到文章展示页面
            return "redirect:/teamAdmin/achievements?type=1";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    /**
     * 处理单独自动处理切换可见性
     */
    @GetMapping("/achievements/switchViewStatus")
    public String switchViewStatus(@RequestParam("id") int id, Model model, @RequestParam("type") int type) {
        // 目前只有一个团队
        Integer teamID = 1;

        if (type == 0) {
            // 获取现有的成果
            Achievement achievement = achievementService.getAchievementById(id);
            if (achievement == null) {
                model.addAttribute("error", "未找到指定的科研成果。");
                return "/TeamAdmin/error";
            }

            // 切换可见性
            if (achievement.getViewStatus() == 1) {
                achievementService.updateAchievementVisibility(id, 0);
            } else if (achievement.getViewStatus() == 0) {
                achievementService.updateAchievementVisibility(id, 1);
            } else {
                model.addAttribute("error", "科研成果可见性的值异常！。");
                return "/TeamAdmin/error";
            }

            // 重定向到成果展示页面
            return "redirect:/teamAdmin/achievements?type=0";
        } else if (type == 1) {
            // 获取现有的文章
            Article article = articleService.getArticleById(id);
            if (article == null) {
                model.addAttribute("error", "未找到指定的文章。");
                return "/TeamAdmin/error";
            }

            // 切换可见性
            if (article.getViewStatus() == 1) {
                articleService.updateArticleVisibility(id, 0);
            } else if (article.getViewStatus() == 0) {
                articleService.updateArticleVisibility(id, 1);
            } else {
                model.addAttribute("error", "文章可见性的值异常！");
                return "/TeamAdmin/error";
            }

            // 重定向到文章展示页面
            return "redirect:/teamAdmin/achievements?type=1";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    // 根据传入的状态切换可见性
    @GetMapping("/achievements/switchViewStatusByStatus")
    public String switchViewStatusByStatus(@RequestParam("ids") List<Integer> selectedIds, @RequestParam("status") int status, @RequestParam("type") int type, Model model) {
        // 目前只有一个团队
        Integer teamID = 1;

        if (type == 0) {
            for (int id : selectedIds) {
                // 获取现有的成果
                Achievement achievement = achievementService.getAchievementById(id);
                if (achievement == null) {
                    model.addAttribute("error", "未找到指定的科研成果。");
                    return "/TeamAdmin/error";
                }
                // 切换可见性
                achievementService.updateAchievementVisibility(id, status);
            }
            // 重定向到成果展示页面
            return "redirect:/teamAdmin/achievements?type=0";
        } else if (type == 1) {
            for (int id : selectedIds) {
                // 获取现有的成果
                Article article = articleService.getArticleById(id);
                if (article == null) {
                    model.addAttribute("error", "未找到指定的文章。");
                    return "/TeamAdmin/error";
                }
                // 切换可见性
                articleService.updateArticleVisibility(id, status);
            }
            // 重定向到成果展示页面
            return "redirect:/teamAdmin/achievements?type=1";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    /**
     * 处理删除文件的请求
     */
    @PostMapping("/achievements/edit/deleteFile")
    public String deleteFile(@RequestParam("fileID") int fileID, @RequestParam("id") int id, @RequestParam("type") int type, HttpServletResponse response, Model model) {
        if (type == 0) {
            try {
                // 根据 fileID 获取 AchievementFile 对象
                AchievementFile file = achievementFileService.getFilesByFileID(fileID);
                if (file == null) {
                    model.addAttribute("error", "未找到指定的文件。");
                    return "/TeamAdmin/error";
                }

                // 删除本地的附件/图片
                deleteLocationFile(file.getFilePath(), file.getType());

                // 从数据库中删除 AchievementFile 记录
                achievementFileService.deleteAchievementFile(fileID);

            } catch (Exception e) {
                model.addAttribute("error", "删除文件时发生错误，请重试。");
                e.printStackTrace();
                return "/TeamAdmin/error";
            }

            // 重定向回编辑页面，刷新附件和图片列表
            return "redirect:/teamAdmin/achievements/edit?id=" + id + "&type=0";
        } else if (type == 1) {
            try {
                // 根据 fileID 获取 ArticleFile 对象
                ArticleFile file = articleFileService.getFileByFileID(fileID);
                if (file == null) {
                    model.addAttribute("error", "未找到指定的文件。");
                    return "/TeamAdmin/error";
                }

                // 删除本地的附件/图片
                deleteLocationFile(file.getFilePath(), file.getType());

                // 从数据库中删除 ArticleFile 记录
                articleFileService.deleteArticleFile(fileID);

            } catch (Exception e) {
                model.addAttribute("error", "删除文件时发生错误，请重试。");
                e.printStackTrace();
                return "/TeamAdmin/error";
            }

            // 重定向回编辑页面，刷新附件和图片列表
            return "redirect:/teamAdmin/achievements/edit?id=" + id + "&type=1";
        }
        model.addAttribute("error", "错误的type，0表示科研成果；1表示文章。");
        return "/TeamAdmin/error";
    }

    // type=0，删除文件； type=1，删除图片；
    public Boolean deleteLocationFile(String filePath, int type) {
        // 构建文件的绝对路径
        String baseDir = "C:/Users/zwb/Desktop/JavaWeb课设/";

        // 确保 filePath 以 "uploads\" 开头
        if (filePath.startsWith("uploads\\")) {
            filePath = filePath.substring("uploads\\".length());
        }
        // 替换所有正斜杠为系统路径分隔符（Windows 为 '\\'）
        filePath = filePath.replace("/", "\\");

        File physicalFile = null;
        if (type == 0) {
            physicalFile = new File(baseDir + filePath);
        } else if (type == 1) {
            physicalFile = new File(filePath);
        }

        if (physicalFile.exists()) {
            boolean deleted = physicalFile.delete();
            if (!deleted) {
                System.out.println("权限不足，无法删除！");
                return false;
            }
        } else {
            // 文件不存在，可能已经被手动删除
            System.out.println("文件在本地不存在！");
            return false;
        }
        return true;
    }

    //跳转详情界面
    @GetMapping("/RegisterReview/Details")
    public String RegisterDetails(Model model, @RequestParam("username") String username, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        RegistrationReview registrationReview = registrationService.getRegisterByusername(username);
        model.addAttribute("registrationReview", registrationReview);
        return "TeamAdmin/RegisterDetailsView";
    }

    //跳转用户管理（注销和重置密码)
    @GetMapping("ToUserManage")
    public String ToUserManage(Model model, @RequestParam(required = false) String message, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }
        //判断是否有权限
        if(administratorService.getUserManageAdministrator(currentUser.getUserID())==false){
            return "redirect:/NoAdministrator.jsp";
        }

        List<User> users = userService.findTeamMemberAndVisitor();
        model.addAttribute("users", users);
        model.addAttribute("message", message);
        return "TeamAdmin/UserManage";
    }

    //注销用户
    @GetMapping("UserManage/logoutUser")
    public String logoutUser(RedirectAttributes redirectAttributes, @RequestParam("userID") int userID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }
        //判断是否有权限
        if (administratorService.getUserManageAdministrator(currentUser.getUserID()) == false) {
            return "redirect:/NoAdministrator.jsp";
        }

        User logoutUser = userService.findById(userID);
        String ReceviceAddress = logoutUser.getEmail();
        int r = userService.deleteById(userID);
        if (r > 0) {
            sendMailService.sendMessageEmail(ReceviceAddress, "注销成功");
            redirectAttributes.addAttribute("message", "注销用户成功");
        } else {
            redirectAttributes.addAttribute("message", "注销用户失败");
        }
        return "redirect:/teamAdmin/ToUserManage";
    }

    //批量注销
    @RequestMapping("/UserManage/BatchLogoutUser")
    @ResponseBody
    public Map<String, Object> LogoutUserBatch(@RequestBody Map<String, List<Integer>> requestData,
                                                   HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        }

        List<Integer> userIds = requestData.get("userIds");
        System.out.println("Received user IDs: " + userIds); // 打印接收到的用户ID列表
        if (userIds == null || userIds.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的成员");
            return response;
        }

        // 批量执行
        try {
            for (Integer userID : userIds) {
                User logoutUser = userService.findById(userID);
                String ReceviceAddress = logoutUser.getEmail();
                int r = userService.deleteById(userID);
                sendMailService.sendMessageEmail(ReceviceAddress, "注销成功");
            }
            response.put("success", true);
            response.put("message", "注销成功");
        } catch (Exception e) {
            e.printStackTrace();  // 打印堆栈信息
            response.put("success", false);
            response.put("message", "注销失败：" + e.getMessage());
        }
        return response;
    }

    //重置密码
    @GetMapping("/UserManage/ResetPassword")
    public String ResetPassword(RedirectAttributes redirectAttributes, @RequestParam("userID") int userID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }
        //判断是否有权限
        if (administratorService.getUserManageAdministrator(currentUser.getUserID()) == false) {
            return "redirect:/NoAdministrator.jsp";
        }

        User user = userService.findById(userID);
        String password = sendMailService.resetPassword(user.getEmail());
        if (password.equals("no")) {
            redirectAttributes.addAttribute("message", "重置密码失败，用户邮箱错误");
        } else {
            int r = userService.ResetPassword(userID, password);
            redirectAttributes.addAttribute("message", "重置密码成功");
        }
        return "redirect:/teamAdmin/ToUserManage";
    }

    //批量重置
    @RequestMapping("/UserManage/BatchResetUser")
    @ResponseBody
    public Map<String, Object> ResetUserBatch(@RequestBody Map<String, List<Integer>> requestData,
                                               HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        }

        List<Integer> userIds = requestData.get("userIds");
        System.out.println("Received user IDs: " + userIds); // 打印接收到的用户ID列表
        if (userIds == null || userIds.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的成员");
            return response;
        }

        // 批量执行
        try {
            for (Integer userID : userIds) {
                User user = userService.findById(userID);
                String password = sendMailService.resetPassword(user.getEmail());
                userService.ResetPassword(userID, password);
            }
            response.put("success", true);
            response.put("message", "重置成功");
        } catch (Exception e) {
            e.printStackTrace();  // 打印堆栈信息
            response.put("success", false);
            response.put("message", "重置失败：" + e.getMessage());
        }
        return response;
    }

    //用户搜索
    @GetMapping("/UserManage/searchUsers")
    public String searchUsers(Model model, @RequestParam(value = "username", required = false) String username, @RequestParam(value = "roleType", required = false) String roleType, @RequestParam(value = "status", required = false) Integer status, @RequestParam(value = "registrationTime", required = false) String registrationTime, @RequestParam(value = "email", required = false) String email, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        System.out.println(username);
        System.out.println(roleType);
        System.out.println(status);
        System.out.println(registrationTime);
        System.out.println(email);
        List<User> users = userService.searchUsers(username, roleType, status, registrationTime, email);
        model.addAttribute("users", users);
        return "TeamAdmin/UserManage";
    }


    //跳转到申请注销用户列表
    @GetMapping("/UserManage/ToLogoutList")
    public String ToLogoutList(Model model, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }
        //判断是否有权限
        if(administratorService.getUserManageAdministrator(currentUser.getUserID())==false){
            return "redirect:/NoAdministrator.jsp";
        }

        ArrayList<User> users = new ArrayList<User>();
        List<DeactivationReview> list = deactivationService.findDeactivationPendingUser();
        for (DeactivationReview deactivationReview : list) {
            users.add(userService.findById(deactivationReview.getUserID()));
        }

        model.addAttribute("users", users);
        return "TeamAdmin/LogoutList";
    }
}
