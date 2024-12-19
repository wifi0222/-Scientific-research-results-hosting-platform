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
}
