package com.example.model;

import java.util.Date;

public class Article {
    private int articleID; // 文章ID
    private String title; // 文章标题
    private String category; // 类别（SCI\EI\核心）
    private String abstractContent; // 摘要
    private String contents; // 内容
    private Date publishDate; // 发布日期
    private int teamID; // 团队ID
    private int status; // 状态（0: 待审核，1: 审核成功，-1: 审核失败）
    private int viewStatus; // 查看状态（0: 隐藏，1: 公开）
    private String refusalReason; // 审核拒绝的理由

    // Getter 和 Setter
    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
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

    public String getAbstractContent() {
        return abstractContent;
    }

    public void setAbstractContent(String abstractContent) {
        this.abstractContent = abstractContent;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
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

    public String getRefusalReason() {
        return refusalReason;
    }
}
