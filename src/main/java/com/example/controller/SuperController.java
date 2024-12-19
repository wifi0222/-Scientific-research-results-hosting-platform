package com.example.controller;

import com.example.model.TeamAdministrator;
import com.example.model.User;
import com.example.service.AdministratorService;
import com.example.service.ISendMailService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
/*
超级管理员进行用户管理和权限管理
 */
@Controller
public class SuperController {
    @Autowired
    private UserService userService;

    @Autowired
    private ISendMailService sendMailService;
    @Autowired
    private AdministratorService administratorService;


    //超级管理员用户点击用户管理进行
    @GetMapping("/UserManagement")
    public String UserManagement(Model model,@ModelAttribute("AddTeamAdminRemind")String AddTeamAdminRemind,
    @ModelAttribute("ChangeTeamAdminRemind")String ChangeTeamAdminRemind){
        List<User> users = userService.findAllTeamAdmin();
        if(users.size() > 0){
            model.addAttribute("users", users);
        }else{
            model.addAttribute("message", "暂时没有团队管理员");
        }
        // 如果存在错误信息（来自 AddTeamAdmin），显示错误信息
        System.out.println(AddTeamAdminRemind);
        System.out.println(ChangeTeamAdminRemind);
        return "SuperUserManage";
    }


    //发送重置密码邮件
    @GetMapping("/SendEmail")
    public String getVeriy(@RequestParam("email")String email, Model model) throws Exception {
        sendMailService.resendEmail("",email);
        return "index";

    }

    //增加团队管理员
    @GetMapping("/AddTeamAdmin")
    public String addTeamAdmin(@RequestParam("username")String username,@RequestParam("password") String password,
                               RedirectAttributes redirectAttributes){
        System.out.println("用户名："+username+"密码"+password);
        String information="新增团队管理员成功";
        if(userService.findByUserName(username)!=null){
            information="用户名已存在，新增团队管理员失败，请重新输入";
        }
        userService.addTeamAdmin(username,password);
        redirectAttributes.addAttribute("AddTeamAdminRemind",information);
        return "redirect:/UserManagement";
    }

    //跳转到编辑信息界面
    @GetMapping("/ToChangeTeamAdmin")
    public String ChangeTeamAdmin(Model model,@RequestParam("userID")int userID){
        //通过userID获得user信息
        User user=userService.findById(userID);
        model.addAttribute("user",user);
        return "ChangeTeamAdmin";
    }

    //编辑团队管理员信息
    @RequestMapping ("ChangeTeamAdminInfo")
    public String ChangeTeamAdminInfo(RedirectAttributes redirectAttributes,@ModelAttribute User user) {
        System.out.println(user);
        System.out.println(user.getUsername());
        int n=userService.updateTeamAdmin(user);
        if(n>0){
            redirectAttributes.addAttribute("ChangeTeamAdminRemind","修改成功");
        }else{
            redirectAttributes.addAttribute("ChangeTeamAdminRemind","修改失败");
        }
        return "redirect:/UserManagement";
    }

    //删除团队管理员
    @RequestMapping("DeleteTeamAdmin")
    public String DeleteTeamAdmin(@RequestParam("userID")int userID){
        userService.deleteTeamAdmin(userID);
        return "redirect:/UserManagement";
    }

    //跳转到权限管理的界面：
    @RequestMapping("TeamAdministratorManagement")
    public String TeamAdministratorManagement(Model model,@RequestParam(required = false)String message){
        List<TeamAdministrator> teamAdministrators=administratorService.findAllAdministrators();
        model.addAttribute("teamAdministrators",teamAdministrators);
        model.addAttribute("message",message);
        return "TAdministratorManage";
    }

    @RequestMapping("ToEditTA")
    public String editTA(@RequestParam("adminID")int adminID,Model model){
        TeamAdministrator teamAdministrator=administratorService.findAdministratorById(adminID);
        model.addAttribute("teamAdministrator",teamAdministrator);
        return "editTA";
    }

    @RequestMapping("editAdministrator")
    public String editAdministrator(@RequestParam("set")String set,RedirectAttributes redirectAttributes,
                                    @RequestParam(required = false) boolean publishPermission,
                                    @RequestParam(required = false) boolean userPermission,
                                    @RequestParam(required = false) boolean deletePermission,
                                    @RequestParam("adminID")int adminID){
        if(set.equals("setModelAdministrator")){
            //设置模板权限
            administratorService.setTemplePermission(adminID);
        } else{
            //全部权限设置
            administratorService.setAllPermission(publishPermission,userPermission,deletePermission,adminID);
        }

        redirectAttributes.addAttribute("message","成功修改权限");
        return "redirect:/TeamAdministratorManagement";
    }
}

