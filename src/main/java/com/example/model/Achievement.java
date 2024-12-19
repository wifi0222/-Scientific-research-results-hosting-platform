package com.example.model;

public class Achievement {
    private int achievementID; // 成果ID
    private String title; // 成果标题
    private String category; // 成果类别
    private String abstractText; // 摘要
    private String detailedDescription; // 详细描述
    private String content; // 内容
    private String attachmentLink; // 附件链接
    private String creationTime; // 创建时间
    private int teamID; // 团队ID
    private int status; // 成果状态
    private int viewStatus; // 可见状态

    // Getter 和 Setter 方法
    public int getAchievementID() {
        return achievementID;
    }

    public void setAchievementID(int achievementID) {
        this.achievementID = achievementID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getAbstractText() {
        return abstractText;
    }

    public void setAbstractText(String abstractText) {
        this.abstractText = abstractText;
    }

    public String getDetailedDescription() {
        return detailedDescription;
    }

    public void setDetailedDescription(String detailedDescription) {
        this.detailedDescription = detailedDescription;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAttachmentLink() {
        return attachmentLink;
    }

    public void setAttachmentLink(String attachmentLink) {
        this.attachmentLink = attachmentLink;
    }

    public String getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(String creationTime) {
        this.creationTime = creationTime;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getViewStatus() {
        return viewStatus;
    }

    public void setViewStatus(int viewStatus) {
        this.viewStatus = viewStatus;
    }
}
