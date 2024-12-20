package com.example.controller;


import com.example.model.*;
import com.example.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

//团队管理员
@Controller
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

    //跳转到团队基本信息维护
    @RequestMapping("/TeamInfo")
    public String TeamInfo(Model model) {
        Team team = teamService.getTeam();
        model.addAttribute("team", team);
        return "TeamInfoManage";
    }

    //更新团队信息
    @RequestMapping("/TeamInfoEdit")
    public String TeamInfoEdit(Model model, @ModelAttribute Team team) {
        teamService.updateTeamInfo(team);
        model.addAttribute("message", "修改团队信息成功");
        return "index";
    }

    //跳转到团队成员管理
    @RequestMapping("/TeamMember")
    public String TeamMember(Model model) {
        List<User> members=userService.findAllTeamMember();
        model.addAttribute("members", members);
        return "TeamMemberManage";
    }

    //添加团队成员
    @RequestMapping("/addTeamMember")
    public String addTeamMember(Model model, @ModelAttribute User TeamMember) {
        System.out.println(TeamMember);
        userService.addTeamMember(TeamMember);
        return "index";
    }

    //跳转编辑团队成员信息
    @RequestMapping("/ToChangeTeamMember")
    public String ToChangeTeamMember(Model model, @RequestParam("userID")int userID) {
        User user=userService.findById(userID);
        model.addAttribute("user",user);
        return "ChangeTeamMember";
    }

    //编辑团队成员信息
    @PostMapping("TeamMemberEdit")
    public String TeamMemberEdit(Model model, @ModelAttribute User TeamMember) {
        System.out.println(TeamMember);
        userService.updateTeamMember(TeamMember);
        return "redirect:/TeamMember";
    }

    //跳转用户审核
    @GetMapping("ToMemberInfoReview")
    public String MemberInfoReview(Model model,String message) {
        List<MemberReview> memberReviews=memberViewService.getMemberReviews();
        model.addAttribute("memberReviews", memberReviews);
        if(message!=null){
            model.addAttribute("message", message);
        }
        return "MemberReviewInfo";
    }

    //处理审核
    @GetMapping("SubmitMemberReview")
    public String SubmitMemberReview(RedirectAttributes redirectAttributes, @RequestParam("memberID") int memberID, @RequestParam("status") int status,
                                     @RequestParam(required = false)String refuseReason) {
        if (status == 1) {
            //更新审核结果和用户的信息
            MemberReview memberReview=memberViewService.findByMemberID(memberID);
            memberViewService.updateSuccessResult(memberID);
            userService.updateTeamMemberInfo(memberReview);
        }else {
            //更新审核结果和拒绝原因
            memberViewService.updateFailResult(memberID,refuseReason);
        }
        redirectAttributes.addAttribute("message","审核成功");
        return "redirect:/ToMemberInfoReview";
    }

    //跳转到用户管理模块
    @GetMapping("ToUserRegisterManage")
    public String ToTeamUserManage(Model model,@RequestParam(required = false)String message) {
        List<RegistrationReview> users=registrationService.getAllRegistrationReviews();
        model.addAttribute("users", users);
        model.addAttribute("message",message);
        return "UserRegisterManage";
    }

    //处理审核
    @GetMapping("SubmitRegisterReview")
    public String SubmitRegisterReview(RedirectAttributes redirectAttributes, @RequestParam("username") String username, @RequestParam("status") int status,
                                       @RequestParam(required = false)String refuseReason ) {
       System.out.println("获得的信息"+username);
        RegistrationReview registrationReview=registrationService.getRegisterByusername(username);
        String sendMessage; //通过邮件发送的通知
        String sendEmail=registrationReview.getEmail(); //发送邮件的邮箱
        if (status == 1) {
            //通过审核---插入用户表里面，更新状态，发送通知
            sendMessage="您的注册申请审核已通过,请及时登录";
            userService.addNewUser(registrationReview);
            registrationService.updateSuccessResult(username);
        }else {
            //审核失败---更新状态，发送通知
            sendMessage="您的注册申请审核未通过,请重新提交";
            registrationService.updateFailResult(username,refuseReason);
        }
        sendMailService.sendMessageEmail(sendEmail,sendMessage);
        redirectAttributes.addAttribute("message","审核成功");
        return "redirect:/ToUserRegisterManage";
    }

    //跳转详情界面
    @GetMapping("RegisterDetails")
    public String RegisterDetails(Model model,@RequestParam("username")String username){
        RegistrationReview registrationReview=registrationService.getRegisterByusername(username);
        model.addAttribute("registrationReview", registrationReview);
        return "RegisterDetailsView";
    }

    //跳转用户管理（注销和重置密码)
    @GetMapping("ToUserManage")
    public String ToUserManage(Model model,@RequestParam(required = false)String message) {
        List<User> users=userService.findTeamMemberAndVisitor();
        model.addAttribute("users", users);
        model.addAttribute("message", message);
        return "UserManage";
    }

    //注销用户
    @GetMapping("logoutUser")
    public String logoutUser(RedirectAttributes redirectAttributes,@RequestParam("userID")int userID ){
        int r=userService.deleteById(userID);
        if(r>0) {
            redirectAttributes.addAttribute("message", "注销用户成功");
        }else{
            redirectAttributes.addAttribute("message","注销用户失败");
        }
        return "redirect:/ToUserManage";
    }

    //重置密码
    @GetMapping("ResetPassword")
    public String ResetPassword(RedirectAttributes redirectAttributes,@RequestParam("userID")int userID ) {
        User user=userService.findById(userID);
        String password=sendMailService.resetPassword(user.getEmail());
        if(password.equals("no")){
            redirectAttributes.addAttribute("message","重置密码失败，用户邮箱错误");
        }else{
            int r=userService.ResetPassword(userID,password);
            redirectAttributes.addAttribute("message","重置密码成功");
        }
        return "redirect:/ToUserManage";
    }

    //用户搜索
    @GetMapping("searchUsers")
    public String searchUsers(Model model,@RequestParam(value = "username", required = false) String username,
                              @RequestParam(value = "roleType", required = false) String roleType,
                              @RequestParam(value = "status", required = false) Integer status,
                              @RequestParam(value = "registrationTime", required = false) String registrationTime,
                              @RequestParam(value = "email", required = false) String email) {
        System.out.println(username);
        System.out.println(roleType);
        System.out.println(status);
        System.out.println(registrationTime);
        System.out.println(email);
        List<User> users=userService.searchUsers(username,roleType,status,registrationTime,email);
        model.addAttribute("users", users);
        return "UserManage";
    }


    //跳转到申请注销用户列表
    @GetMapping("ToLogoutList")
    public String ToLogoutList(Model model) {
        ArrayList<User> users=new ArrayList<User>();
        List<DeactivationReview> list=deactivationService.findDeactivationPendingUser();
        for(DeactivationReview deactivationReview:list){
            users.add(userService.findById(deactivationReview.getUserID()));
        }
        model.addAttribute("users", users);
        return "LogoutList";
    }
}
