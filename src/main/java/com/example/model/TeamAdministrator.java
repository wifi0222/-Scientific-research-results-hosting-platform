package com.example.model;

public class TeamAdministrator {
    int adminID; //团队管理员ID
    String adminName; //团队管理员姓名
    String adminUsername; //团队管理员用户名
    boolean publishPermission; //权限1
    boolean userPermission; //权限2
    boolean deletePermission; //权限3

    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public boolean getPublishPermission() {
        return publishPermission;
    }

    public void setPublishPermission(boolean publishPermission) {
        this.publishPermission = publishPermission;
    }

    public boolean getUserPermission() {
        return userPermission;
    }

    public void setUserPermission(boolean userPermission) {
        this.userPermission = userPermission;
    }

    public boolean getDeletePermission() {
        return deletePermission;
    }

    public void setDeletePermission(boolean deletePermission) {
        this.deletePermission = deletePermission;
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

    @Override
    public String toString() {
        return "TeamAdministrator{" +
                "adminID=" + adminID +
                ", adminName='" + adminName + '\'' +
                ", adminUsername='" + adminUsername + '\'' +
                ", publishPermission=" + publishPermission +
                ", userPermission=" + userPermission +
                ", deletePermission=" + deletePermission +
                '}';
    }
}
