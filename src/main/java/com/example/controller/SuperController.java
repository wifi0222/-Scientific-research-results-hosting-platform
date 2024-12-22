package com.example.controller;

import com.example.model.*;
import com.example.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
超级管理员进行用户管理和权限管理
 */
@Controller
@RequestMapping("/SuperController")
public class SuperController {
    @Autowired
    private UserService userService;
    @Autowired
    private TeamService teamService;
    @Autowired
    private ISendMailService sendMailService;
    @Autowired
    private AdministratorService administratorService;
    @Autowired
    private DeactivationService deactivationService;
    @Autowired
    private AchievementService achievementService;
    @Autowired
    private AchievementFileService achievementFileService;

    //超级管理员用户点击用户管理进行
    @GetMapping("/UserManagement")
    public String UserManagement(Model model, @RequestParam(required = false) String AddTeamAdminRemind,
                                 @RequestParam(required = false) String ChangeTeamAdminRemind, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        List<User> users = userService.findAllTeamAdmin();
        if (users.size() > 0) {
            model.addAttribute("users", users);
        } else {
            model.addAttribute("message", "暂时没有团队管理员");
        }
        // 如果存在错误信息（来自 AddTeamAdmin），显示错误信息
        System.out.println(AddTeamAdminRemind);
        System.out.println(ChangeTeamAdminRemind);
        return "SuperAdmin/SuperUserManage";
    }

    //跳转到增减团队管理员界面
    @GetMapping("ToAddTeamAdmin")
    public String ToAddTeamAdmin(Model model) {
        List<Team> teams = teamService.getAllTeam();
        model.addAttribute("teams", teams);
        return "SuperAdmin/addTeamAdmin";
    }

    //增加团队管理员
    @GetMapping("/AddTeamAdmin")
    public String addTeamAdmin(@RequestParam("username") String username, @RequestParam("password") String password,
                               RedirectAttributes redirectAttributes, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        System.out.println("用户名：" + username + "密码" + password);
        String information = "新增团队管理员成功";
        if (userService.findByUserName(username) != null) {
            information = "用户名已存在，新增团队管理员失败，请重新输入";
        } else {
            userService.addTeamAdmin(username, password);
        }
        redirectAttributes.addAttribute("AddTeamAdminRemind", information);
        return "redirect:/UserManagement";
    }

    //跳转到编辑信息界面
    @GetMapping("/ToChangeTeamAdmin")
    public String ChangeTeamAdmin(Model model,
                                  HttpSession session, @RequestParam("userID") int userID) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }
        //通过userID获得user信息
        User user = userService.findById(userID);
        model.addAttribute("user", user);
        return "SuperAdmin/ChangeTeamAdmin";
    }

    //编辑团队管理员信息
    @RequestMapping("ChangeTeamAdminInfo")
    public String ChangeTeamAdminInfo(RedirectAttributes redirectAttributes, @ModelAttribute User user, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        System.out.println(user);
        System.out.println(user.getUsername());
        int n = userService.updateTeamAdmin(user);
        if (n > 0) {
            redirectAttributes.addAttribute("ChangeTeamAdminRemind", "修改成功");
        } else {
            redirectAttributes.addAttribute("ChangeTeamAdminRemind", "修改失败");
        }
        return "redirect:/UserManagement";
    }

    //删除团队管理员
    @RequestMapping("DeleteTeamAdmin")
    public String DeleteTeamAdmin(@RequestParam("userID") int userID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        userService.deleteTeamAdmin(userID);
        return "redirect:/UserManagement";
    }

    //跳转到权限管理的界面：
    @RequestMapping("TeamAdministratorManagement")
    public String TeamAdministratorManagement(Model model, @RequestParam(required = false) String message, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        List<TeamAdministrator> teamAdministrators = administratorService.findAllAdministrators();
        model.addAttribute("teamAdministrators", teamAdministrators);
        model.addAttribute("message", message);
        return "SuperAdmin/TAdministratorManage";
    }

    @RequestMapping("ToEditTA")
    public String editTA(@RequestParam("adminID") int adminID, Model model, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        TeamAdministrator teamAdministrator = administratorService.findAdministratorById(adminID);
        model.addAttribute("teamAdministrator", teamAdministrator);
        return "SuperAdmin/editTA";
    }

    @RequestMapping("editAdministrator")
    public String editAdministrator(@RequestParam("set") int set, RedirectAttributes redirectAttributes,
                                    @RequestParam(required = false) boolean publishPermission,
                                    @RequestParam(required = false) boolean userPermission,
                                    @RequestParam(required = false) boolean deletePermission,
                                    @RequestParam("adminID") int adminID,
                                    HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        System.out.println(set);
        if (set == 1) {
            //设置模板权限
            System.out.println("设置模版权限");
            administratorService.setTemplePermission(adminID);
        } else {
            //全部权限设置
            System.out.println("设置全部权限");
            administratorService.setAllPermission(publishPermission, userPermission, deletePermission, adminID);
        }

        redirectAttributes.addAttribute("message", "成功修改权限");
        return "redirect:/TeamAdministratorManagement";
    }


    /**
     * 超级用户审核研究成果
     */
    @GetMapping("/auditAchievements")
    public String auditAchievements(HttpSession session, Model model) {
        // 目前只有一个团队
        int teamID = 1;

        // 获取团队所有成果列表
        List<Achievement> achievements = achievementService.getAchievementsByTeam(teamID);

        Map<Achievement, List<AchievementFile>> auditAchievementMap = new HashMap<Achievement, List<AchievementFile>>();

        for (Achievement a : achievements) {
            if (a.getStatus() == 0) {
                // 获取待审核的成果的附件和图片
                List<AchievementFile> achievementFiles = achievementFileService.getFilesByAchievementId(a.getAchievementID());
                auditAchievementMap.put(a, achievementFiles);
            }
        }

        model.addAttribute("auditAchievementMap", auditAchievementMap);

        return "/SuperAdmin/auditAchievements";
    }

    /**
     * 超级用户通过审核
     */
    @GetMapping("/auditAchievements/pass")
    public String passAchievementReview(@RequestParam("id") int achievementID, Model model) {
        achievementService.updateAchievementStatus(achievementID, 1);
        return "redirect:/SuperController/auditAchievements";
    }

    /**
     * 超级用户拒绝审核
     */
    @GetMapping("/auditAchievements/reject")
    public String rejectAchievementReview(@RequestParam("id") int achievementID, Model model) {
        achievementService.updateAchievementStatus(achievementID, -1);
        return "redirect:/SuperController/auditAchievements";
    }
}

