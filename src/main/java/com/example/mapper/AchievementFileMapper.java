package com.example.mapper;

import com.example.model.AchievementFile;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AchievementFileMapper {
    List<AchievementFile> getFilesByAchievementId(@Param("achievementID") int achievementID);
    AchievementFile getFilesByFileID(int fileID);
    void insertAchievementFile(AchievementFile achievementFile);
    int deleteAchievementFile(int fileID);
}
