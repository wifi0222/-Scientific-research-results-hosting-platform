package com.example.service.Impl;

import com.example.mapper.AchievementMapper;
import com.example.model.Achievement;
import com.example.service.AchievementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AchievementServiceImpl implements AchievementService {

    @Autowired
    private AchievementMapper achievementMapper;

    @Override
    public List<Achievement> getAchievementsByTeam(int teamID) {
        return achievementMapper.getAchievementsByTeam(teamID);
    }

    // 实现新增成果方法
    @Override
    public Achievement insertAchievement(Achievement achievement) {
        achievementMapper.insertAchievement(achievement);
        // 插入后，achievement对象的 achievementID 会被自动赋值
        return achievement;
    }

    @Override
    public Achievement getAchievementById(int achievementID) {
        return achievementMapper.getAchievementById(achievementID);
    }

    @Override
    public int updateAchievement(Achievement achievement) {
        return achievementMapper.updateAchievement(achievement);
    }

    @Override
    public int deleteAchievement(int achievementID) {
        return achievementMapper.deleteAchievement(achievementID);
    }

    @Override
    public int updateAchievementVisibility(int achievementID, int viewStatus) {
        return achievementMapper.updateAchievementVisibility(achievementID, viewStatus);
    }

    @Override
    public int updateAchievementStatus(int achievementID, int status) {
        return achievementMapper.updateAchievementStatus(achievementID, status);
    }

    @Override
    public int updateRefusalReason(int achievementID, String refusalReason) {
        return achievementMapper.updateRefusalReason(achievementID, refusalReason);
    }
}
