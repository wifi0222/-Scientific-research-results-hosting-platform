package com.example.service.Impl;

import com.example.mapper.AchievementFileMapper;
import com.example.model.AchievementFile;
import com.example.service.AchievementFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AchievementFileServiceImpl implements AchievementFileService {

    @Autowired
    private AchievementFileMapper achievementFileMapper;

    @Override
    public List<AchievementFile> getFilesByAchievementId(int achievementID) {
        return achievementFileMapper.getFilesByAchievementId(achievementID);
    }

    @Override
    @Transactional  // 事务
    public void insertAchievementFile(AchievementFile achievementFile) {
        achievementFileMapper.insertAchievementFile(achievementFile);
    }

    @Override
    public AchievementFile getFilesByFileID(int fileID) {
        return achievementFileMapper.getFilesByFileID(fileID);
    }

    @Override
    public int deleteAchievementFile(int fileID) {
        return achievementFileMapper.deleteAchievementFile(fileID);
    }
}
