package com.example.service;

import com.example.model.Achievement;

import java.util.List;

public interface AchievementService {
    List<Achievement> getAchievementsByTeam(int teamID);

    // 插入科研成果
    Achievement insertAchievement(Achievement achievement);
}
