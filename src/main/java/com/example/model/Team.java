package com.example.model;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Team {
    private int teamID;
    private String teamName;
    private String researchArea;
    private String introduction;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date creationTime;

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getResearchArea() {
        return researchArea;
    }

    public void setResearchArea(String researchArea) {
        this.researchArea = researchArea;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    @Override
    public String toString() {
        return "Team{" +
                "teamID=" + teamID +
                ", teamName='" + teamName + '\'' +
                ", researchArea='" + researchArea + '\'' +
                ", introduction='" + introduction + '\'' +
                ", creationTime=" + creationTime +
                '}';
    }
}
