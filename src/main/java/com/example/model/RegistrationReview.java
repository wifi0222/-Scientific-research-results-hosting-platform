package com.example.model;

import java.util.Date;

public class RegistrationReview {

    private String username;             // 用户名
    private String password;             // 密码
    private String roleType;             // 角色类型（团队成员或普通用户）
    private String email;                // 邮箱
    private Date registrationTime;       // 注册时间
    private int registrationStatus;      // 注册状态（0: 待审核，1: 审核通过，-1: 审核失败）
    private String applicationReason;    // 申请理由
    private String refuseReason;         // 审核失败理由

    // 默认构造方法
    public RegistrationReview() {
    }

    // 带参构造方法
    public RegistrationReview(String username, String password, String roleType, String email, Date registrationTime, int registrationStatus, String applicationReason, String refuseReason) {
        this.username = username;
        this.password = password;
        this.roleType = roleType;
        this.email = email;
        this.registrationTime = registrationTime;
        this.registrationStatus = registrationStatus;
        this.applicationReason = applicationReason;
        this.refuseReason = refuseReason;
    }

    // Getter 和 Setter 方法
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getRegistrationTime() {
        return registrationTime;
    }

    public void setRegistrationTime(Date registrationTime) {
        this.registrationTime = registrationTime;
    }

    public int getRegistrationStatus() {
        return registrationStatus;
    }

    public void setRegistrationStatus(int registrationStatus) {
        this.registrationStatus = registrationStatus;
    }

    public String getApplicationReason() {
        return applicationReason;
    }

    public void setApplicationReason(String applicationReason) {
        this.applicationReason = applicationReason;
    }

    public String getRefuseReason() {
        return refuseReason;
    }

    public void setRefuseReason(String refuseReason) {
        this.refuseReason = refuseReason;
    }

    // 重写 toString 方法，便于调试时查看对象内容
    @Override
    public String toString() {
        return "RegistrationReview{" +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", roleType='" + roleType + '\'' +
                ", email='" + email + '\'' +
                ", registrationTime=" + registrationTime +
                ", registrationStatus=" + registrationStatus +
                ", applicationReason='" + applicationReason + '\'' +
                ", refuseReason='" + refuseReason + '\'' +
                '}';
    }
}
