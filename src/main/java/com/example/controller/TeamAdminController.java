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

import javax.servlet.http.HttpSession;
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

    //跳转到团队基本信息维护
    @RequestMapping("/TeamInfo")
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
    @RequestMapping("/TeamInfoEdit")
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
    @RequestMapping("/TeamMember")
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
    @RequestMapping("/addTeamMember")
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
        return "redirect:/TeamMember";
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
    @PostMapping("TeamMemberEdit")
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
        return "redirect:/TeamMember";
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
    @GetMapping("SubmitMemberReview")
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
        return "redirect:/ToMemberInfoReview";
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

        List<RegistrationReview> users = registrationService.getAllRegistrationReviews();
        model.addAttribute("users", users);
        model.addAttribute("message", message);
        return "TeamAdmin/UserRegisterManage";
    }

    //处理审核
    @GetMapping("SubmitRegisterReview")
    public String SubmitRegisterReview(RedirectAttributes redirectAttributes, @RequestParam("username") String username, @RequestParam("status") int status,
                                       @RequestParam(required = false) String refuseReason, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
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
        return "redirect:/ToUserRegisterManage";
    }

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

        Map<Achievement, List<AchievementFile>> achievementMap = new HashMap<Achievement, List<AchievementFile>>();

        for (Achievement a : achievements) {
            // 获取每个成果的附件和图片
            List<AchievementFile> achievementFiles = achievementFileService.getFilesByAchievementId(a.getAchievementID());
            achievementMap.put(a, achievementFiles);
        }

//        // 将成果列表传递给前端
//        model.addAttribute("achievements", achievements);

        model.addAttribute("achievementMap", achievementMap);
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
            @RequestParam("abstractContent") String abstractContent,
            @RequestParam("contents") String contents,
            @RequestParam("attachmentFile") MultipartFile attachmentFile,
            @RequestParam("coverImage") MultipartFile coverImage,
            @RequestParam("creationTime") String creationTimeStr,
            HttpSession session,
            Model model
    ) {
        // 解析 creationTimeStr 为 Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date creationTime = null;
        try {
            creationTime = sdf.parse(creationTimeStr);
        } catch (ParseException e) {
            model.addAttribute("error", "日期格式错误，请使用yyyy-MM-dd格式。");
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
                    attachmentPath = saveFile(attachmentFile, "C:\\Users\\zwb\\Desktop\\JavaWeb课设\\科研成果附件\\");
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
                    coverImagePath = saveFile(coverImage, "C:\\Users\\zwb\\Desktop\\JavaWeb课设\\科研成果图片\\");
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
        return "redirect:/teamAdmin/achievements";
    }

    // 文件保存方法：文件；文件上传的目录
    private String saveFile(MultipartFile file, String uploadDir) throws Exception {
        if (file.isEmpty()) {
            return null;
        }
        // 生成一个唯一的时间戳，防止文件名冲突
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        File dest = new File(uploadDir + fileName);
        // 确保上传目录存在，不存在，则创建
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }
        //  将上传的文件保存到指定的目录
        file.transferTo(dest);
        return dest.getAbsolutePath();
    }


    //跳转详情界面
    @GetMapping("RegisterDetails")
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

        List<User> users = userService.findTeamMemberAndVisitor();
        model.addAttribute("users", users);
        model.addAttribute("message", message);
        return "TeamAdmin/UserManage";
    }

    //注销用户
    @GetMapping("logoutUser")
    public String logoutUser(RedirectAttributes redirectAttributes, @RequestParam("userID") int userID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
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
        return "redirect:/ToUserManage";
    }

    //重置密码
    @GetMapping("ResetPassword")
    public String ResetPassword(RedirectAttributes redirectAttributes, @RequestParam("userID") int userID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        User user = userService.findById(userID);
        String password = sendMailService.resetPassword(user.getEmail());
        if (password.equals("no")) {
            redirectAttributes.addAttribute("message", "重置密码失败，用户邮箱错误");
        } else {
            int r = userService.ResetPassword(userID, password);
            redirectAttributes.addAttribute("message", "重置密码成功");
        }
        return "redirect:/ToUserManage";
    }

    //用户搜索
    @GetMapping("searchUsers")
    public String searchUsers(Model model, @RequestParam(value = "username", required = false) String username,
                              @RequestParam(value = "roleType", required = false) String roleType,
                              @RequestParam(value = "status", required = false) Integer status,
                              @RequestParam(value = "registrationTime", required = false) String registrationTime,
                              @RequestParam(value = "email", required = false) String email,
                              HttpSession session) {
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
    @GetMapping("ToLogoutList")
    public String ToLogoutList(Model model, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("TeamAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
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
