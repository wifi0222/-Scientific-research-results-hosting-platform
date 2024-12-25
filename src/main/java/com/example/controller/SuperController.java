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
    @GetMapping("/TeamAdminManage/add")
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
        return "redirect:/SuperController/UserManagement";
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
    @RequestMapping("/TeamAdminManage/edit")
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
        return "redirect:/SuperController/UserManagement";
    }

    //删除团队管理员
    @RequestMapping("/TeamAdminManage/delete")
    public String DeleteTeamAdmin(@RequestParam("userID") int userID, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

        userService.deleteTeamAdmin(userID);
        return "redirect:/SuperController/UserManagement";
    }

    //批量删除团队管理员
    @RequestMapping("/TeamAdminManage/deleteBatch")
    @ResponseBody
    public Map<String, Object> deleteBatch(@RequestBody Map<String, List<Integer>> requestData, HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        } else if (!"SuperAdmin".equals(currentUser.getRoleType())) {
            response.put("success", false);
            response.put("message", "权限不足");
            return response;
        }

        List<Integer> userIds = requestData.get("userIds");
        System.out.println("Received User IDs: " + userIds); // 打印接收到的用户ID列表
        if (userIds == null || userIds.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的管理员");
            return response;
        }

        // 执行批量删除操作
        try {
            for (Integer userId : userIds) {
                userService.deleteTeamAdmin(userId); // 执行删除
            }
            response.put("success", true);
            response.put("message", "删除成功");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "删除失败：" + e.getMessage());
        }

        return response;
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

    @RequestMapping("/TeamAdministrator/edit")
    public String editAdministrator( RedirectAttributes redirectAttributes,
//                                     @RequestParam("set") int set,
                                    @RequestParam(required = false) boolean userPermission,
                                    @RequestParam(required = false) boolean publishAchievement,
                                    @RequestParam(required = false) boolean deleteAchievement,
                                    @RequestParam(required = false) boolean editAchievement,
                                    @RequestParam(required = false) boolean setAchievementStatus,
                                    @RequestParam(required = false) boolean publishArticle,
                                    @RequestParam(required = false) boolean deleteArticle,
                                    @RequestParam(required = false) boolean editArticle,
                                    @RequestParam(required = false) boolean setArticleStatus,
                                    @RequestParam("adminID") int adminID,
                                    HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/ManagementLogin.jsp"; // 如果未登录，跳转到登录页面
        } else if (currentUser.getRoleType().equals("SuperAdmin") == false) {
            return "redirect:/ManagementLogin.jsp";    //用户角色判断
        }

//        System.out.println(set);
//        if (set == 1) {
//            //设置模板权限
//            System.out.println("设置模版权限");
//            administratorService.setTemplePermission(adminID);
//        } else {
//            //全部权限设置
//            System.out.println("设置全部权限");
//            administratorService.setAllPermission(publishPermission, userPermission, deletePermission, adminID);
//        }
        administratorService.setAllPermission(
                userPermission,publishAchievement,deleteAchievement,editAchievement,setAchievementStatus,
                publishArticle,deleteArticle,editArticle,setArticleStatus,adminID
        );

        redirectAttributes.addAttribute("message", "成功修改权限");
        return "redirect:/SuperController/TeamAdministratorManagement";
    }

    //批量设置用户管理权限
    @RequestMapping("/TeamAdministrator/setUserAdministrator")
    @ResponseBody
    public Map<String, Object> UserAdministratorBatch(@RequestBody Map<String, List<Integer>> requestData,
                                                      HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        } else if (!"SuperAdmin".equals(currentUser.getRoleType())) {
            response.put("success", false);
            response.put("message", "权限不足");
            return response;
        }

        List<Integer> adminIds = requestData.get("adminIds");
        System.out.println("Received Admin IDs: " + adminIds); // 打印接收到的用户ID列表
        if (adminIds == null || adminIds.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的管理员");
            return response;
        }

        // 批量执行
        try {
            for (Integer adminId : adminIds) {
                administratorService.setUserManageAdministrator(adminId);
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

    //批量设置科研成果权限
    @RequestMapping("/TeamAdministrator/setResearchAdministrator")
    @ResponseBody
    public Map<String, Object> ResearchAdministratorBatch(@RequestBody Map<String, List<Integer>> requestData,
                                                      HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        } else if (!"SuperAdmin".equals(currentUser.getRoleType())) {
            response.put("success", false);
            response.put("message", "权限不足");
            return response;
        }

        List<Integer> adminIds = requestData.get("adminIds");
        System.out.println("Received Admin IDs: " + adminIds); // 打印接收到的用户ID列表
        if (adminIds == null || adminIds.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的管理员");
            return response;
        }

        // 批量执行
        try {
            for (Integer adminId : adminIds) {
                administratorService.setResearchAdministrator(adminId);
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

    //批量设置文章权限
    @RequestMapping("/TeamAdministrator/setArticleAdministrator")
    @ResponseBody
    public Map<String, Object> ArticleAdministratorBatch(@RequestBody Map<String, List<Integer>> requestData,
                                                      HttpSession session) {
        // 获取当前用户
        User currentUser = (User) session.getAttribute("currentUser");

        Map<String, Object> response = new HashMap<>();

        if (currentUser == null) {
            response.put("success", false);
            response.put("message", "用户未登录");
            return response;
        } else if (!"SuperAdmin".equals(currentUser.getRoleType())) {
            response.put("success", false);
            response.put("message", "权限不足");
            return response;
        }

        List<Integer> adminIds = requestData.get("adminIds");
        System.out.println("Received Admin IDs: " + adminIds); // 打印接收到的用户ID列表
        if (adminIds == null || adminIds.isEmpty()) {
            response.put("success", false);
            response.put("message", "没有选中的管理员");
            return response;
        }

        // 批量执行
        try {
            for (Integer adminId : adminIds) {
                administratorService.setArticleAdministrator(adminId);
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

    /**
     * 超级用户拒绝审核
     */
    @GetMapping("/auditAchievements/preview")
    public String previewAchievement(@RequestParam("id") int achievementID, Model model) {
        // 获取指定ID的成果
        Achievement achievement = achievementService.getAchievementById(achievementID);
        if (achievement == null) {
            model.addAttribute("error", "未找到指定的科研成果。");
            return "/TeamAdmin/error";
        }

        // 获取该成果的附件和图片
        List<AchievementFile> achievementFiles = achievementFileService.getFilesByAchievementId(achievementID);

        // 将数据传递给前端
        model.addAttribute("achievement", achievement);
        model.addAttribute("achievementFiles", achievementFiles);

        return "/SuperAdmin/previewAchievement";
    }
}

