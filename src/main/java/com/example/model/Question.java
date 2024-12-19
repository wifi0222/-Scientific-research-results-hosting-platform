package com.example.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Question {
    private int questionID;
    private String questionContent;
    private int userID;
    private int status;
    private LocalDateTime askTime;
    private String replyContent;
    private String replyTime;

    // Getters and setters
    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
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

    public LocalDateTime getAskTime() {
        return askTime;
    }

    public void setAskTime(LocalDateTime  askTime) {
        this.askTime = askTime;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
    }

}

