package com.example.service;

import com.example.model.AchievementFile;

import java.util.List;

public interface AchievementFileService {
    List<AchievementFile> getFilesByAchievementId(int achievementID);
    AchievementFile getFilesByFileID(int fileID);
    void insertAchievementFile(AchievementFile achievementFile);
    int deleteAchievementFile(int fileID);
}
