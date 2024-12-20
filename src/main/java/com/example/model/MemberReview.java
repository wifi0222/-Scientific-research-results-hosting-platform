package com.example.model;

public class MemberReview {
    private int memberID;             // 主键：memberID，引用 User 表的 userID
    private String name;              // 姓名
    private String researchField;     // 研究方向
    private String contactInfo;       // 联系方式
    private String academicBackground; // 学术背景
    private String researchAchievements; // 科研成果
    private int modificationStatus;   // 修改状态（0: 待审核，1: 审核成功，-1: 审核失败）
    private String refuseReason;      // 拒绝理由

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getResearchField() {
        return researchField;
    }

    public void setResearchField(String researchField) {
        this.researchField = researchField;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getAcademicBackground() {
        return academicBackground;
    }

    public void setAcademicBackground(String academicBackground) {
        this.academicBackground = academicBackground;
    }

    public String getResearchAchievements() {
        return researchAchievements;
    }

    public void setResearchAchievements(String researchAchievements) {
        this.researchAchievements = researchAchievements;
    }

    public int getModificationStatus() {
        return modificationStatus;
    }

    public void setModificationStatus(int modificationStatus) {
        this.modificationStatus = modificationStatus;
    }

    public String getRefuseReason() {
        return refuseReason;
    }

    public void setRefuseReason(String refuseReason) {
        this.refuseReason = refuseReason;
    }
}
