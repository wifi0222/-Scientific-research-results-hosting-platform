package com.example.service;

import com.example.model.Achievement;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AchievementService {
    List<Achievement> getAchievementsByTeam(int teamID);

    // 插入科研成果
    Achievement insertAchievement(Achievement achievement);

    Achievement getAchievementById(int achievementID);

    int updateAchievement(Achievement achievement);

    // 删除成果
    int deleteAchievement(int achievementID);

    int updateAchievementVisibility(int achievementID, int viewStatus);
}
