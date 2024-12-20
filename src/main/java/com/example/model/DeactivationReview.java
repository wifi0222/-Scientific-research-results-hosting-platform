package com.example.model;

public class DeactivationReview {
    private int userID;
    private int deactivationStatus;
//    private Date deactivationDate;

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getDeactivationStatus() {
        return deactivationStatus;
    }

    public void setDeactivationStatus(int deactivationStatus) {
        this.deactivationStatus = deactivationStatus;
    }
}
