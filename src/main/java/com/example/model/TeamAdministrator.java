package com.example.model;

public class TeamAdministrator {
    private int adminID;            // 团队管理员ID
    private String adminName;       // 团队管理员姓名
    private String adminUsername;   // 团队管理员用户名
    private boolean publishPermission; // 权限1：发布科研成果权限
    private boolean userPermission;    // 权限2：审核用户权限
    private boolean deletePermission;  // 权限3：删除科研成果权限
    private boolean editPermission; //权限4：编辑科研成果权限
    private boolean setStatusPermission; //权限5：公开/隐藏科研成果权限

    private boolean publishArticle; //权限6：发布文章权限
    private boolean deleteArticle; //权限7：删除文章权限
    private boolean editArticle; //权限8：编辑文章权限
    private boolean setArticleStatus; //权限9:公开/隐藏文章权限


    private int teamID;             // 团队ID

    // Getter 和 Setter 方法

    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminUsername() {
        return adminUsername;
    }

    public void setAdminUsername(String adminUsername) {
        this.adminUsername = adminUsername;
    }

    public boolean isPublishPermission() {
        return publishPermission;
    }

    public void setPublishPermission(boolean publishPermission) {
        this.publishPermission = publishPermission;
    }

    public boolean isUserPermission() {
        return userPermission;
    }

    public void setUserPermission(boolean userPermission) {
        this.userPermission = userPermission;
    }

    public boolean isDeletePermission() {
        return deletePermission;
    }

    public void setDeletePermission(boolean deletePermission) {
        this.deletePermission = deletePermission;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public void setEditPermission(boolean editPermission) {
        this.editPermission = editPermission;
    }
    public void setSetStatusPermission(boolean setStatusPermission) {
        this.setStatusPermission = setStatusPermission;
    }


    public void setPublishArticle(boolean publishArticle) {
        this.publishArticle = publishArticle;
    }


    public void setDeleteArticle(boolean deleteArticle) {
        this.deleteArticle = deleteArticle;
    }

    public void setEditArticle(boolean editArticle) {
        this.editArticle = editArticle;
    }

    public void setSetArticleStatus(boolean setArticleStatus) {
        this.setArticleStatus = setArticleStatus;
    }

    public boolean getEditPermission() {
        return editPermission;
    }

    public boolean getSetStatusPermission() {
        return setStatusPermission;
    }

    public boolean getPublishArticle() {
        return publishArticle;
    }

    public boolean getDeleteArticle() {
        return deleteArticle;
    }

    public boolean getEditArticle() {
        return editArticle;
    }

    public boolean getSetArticleStatus() {
        return setArticleStatus;
    }
}
