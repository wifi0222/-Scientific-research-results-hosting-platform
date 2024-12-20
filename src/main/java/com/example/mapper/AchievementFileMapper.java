package com.example.mapper;

import com.example.model.AchievementFile;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AchievementFileMapper {
    List<AchievementFile> getFilesByAchievementId(@Param("achievementID") int achievementID);
}
