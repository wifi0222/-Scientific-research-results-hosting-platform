package com.example.service;

import com.example.model.AchievementFile;

import java.util.List;

public interface AchievementFileService {
    List<AchievementFile> getFilesByAchievementId(int achievementID);
    AchievementFile getFilesByfileID(int fileID);
    void insertAchievementFile(AchievementFile achievementFile);
    int deleteAchievementFile(int fileID);
}
