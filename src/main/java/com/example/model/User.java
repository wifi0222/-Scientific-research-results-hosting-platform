package com.example.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class User {
    private int userID; // 主键
    private String username; // 用户名
    private String password; // 密码
    private String roleType; // 角色类型
    private String email; // 邮箱

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date registrationTime; // 注册时间

    private int status; // 状态(0: 禁用, 1: 可用)
    private String name; // 姓名
    private String researchField; // 研究方向
    private String contactInfo; // 联系方式
    private String academicBackground; // 学术背景
    private String researchAchievements; // 科研成果

    // Getters 和 Setters
    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRoleType() { return roleType; }
    public void setRoleType(String roleType) { this.roleType = roleType; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Date getRegistrationTime() { return registrationTime; }
    public void setRegistrationTime(Date registrationTime) { this.registrationTime = registrationTime; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getResearchField() { return researchField; }
    public void setResearchField(String researchField) { this.researchField = researchField; }

    public String getContactInfo() { return contactInfo; }
    public void setContactInfo(String contactInfo) { this.contactInfo = contactInfo; }

    public String getAcademicBackground() { return academicBackground; }
    public void setAcademicBackground(String academicBackground) { this.academicBackground = academicBackground; }

    public String getResearchAchievements() { return researchAchievements; }
    public void setResearchAchievements(String researchAchievements) { this.researchAchievements = researchAchievements; }

    @Override
    public String toString() {
        return "User{" +
                "userID=" + userID +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", roleType='" + roleType + '\'' +
                ", email='" + email + '\'' +
                ", registrationTime=" + registrationTime +
                ", status=" + status +
                ", name='" + name + '\'' +
                ", researchField='" + researchField + '\'' +
                ", contactInfo='" + contactInfo + '\'' +
                ", academicBackground='" + academicBackground + '\'' +
                ", researchAchievements='" + researchAchievements + '\'' +
                '}';
    }
}