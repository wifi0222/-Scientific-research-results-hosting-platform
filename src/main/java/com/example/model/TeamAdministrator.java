package com.example.model;

public class TeamAdministrator {
    private int adminID;            // 团队管理员ID
    private String adminName;       // 团队管理员姓名
    private String adminUsername;   // 团队管理员用户名
    private boolean publishPermission; // 权限1：发布科研成果权限
    private boolean userPermission;    // 权限2：审核用户权限
    private boolean deletePermission;  // 权限3：删除科研成果权限
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

    @Override
    public String toString() {
        return "TeamAdministrator{" +
                "adminID=" + adminID +
                ", adminName='" + adminName + '\'' +
                ", adminUsername='" + adminUsername + '\'' +
                ", publishPermission=" + publishPermission +
                ", userPermission=" + userPermission +
                ", deletePermission=" + deletePermission +
                ", teamID=" + teamID +
                '}';
    }
}
