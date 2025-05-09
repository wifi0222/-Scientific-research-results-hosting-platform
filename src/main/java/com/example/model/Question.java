package com.example.model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class Question implements Serializable { // 如果不加 implements Serializable 那么就无法向 Redis 传 Question
    private int questionID;
    private String title;
    private String questionContent;
    private int userID;
    private int status;
    private Date askTime;
    private String replyContent;
    private Date replyTime;
    private String type;
    private int objectID;
    private int teamAdminID;

    // 这两个字段数据库中没有
    private String userName;
    private String teamAdminName;

    // Getters and setters
    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getQuestionContent() {
        return questionContent;
    }

    public void setQuestionContent(String questionContent) {
        this.questionContent = questionContent;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getAskTime() {
        return askTime;
    }

    public void setAskTime(Date  askTime) {
        this.askTime = askTime;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public Date getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(Date replyTime) {
        this.replyTime = replyTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getObjectID() {
        return objectID;
    }

    public void setObjectID(int objectID) {
        this.objectID = objectID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTeamAdminName() {
        return teamAdminName;
    }

    public void setTeamAdminName(String teamAdminName) {
        this.teamAdminName = teamAdminName;
    }

    public int getTeamAdminID() {
        return teamAdminID;
    }

    public void setTeamAdminID(int teamAdminID) {
        this.teamAdminID = teamAdminID;
    }
}

