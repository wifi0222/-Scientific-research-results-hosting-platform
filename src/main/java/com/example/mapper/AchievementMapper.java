package com.example.mapper;

import com.example.model.Achievement;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface AchievementMapper {

    // 插入科研成果
    int insertAchievement(Achievement achievement);
    // 更新科研成果
    int updateAchievement(Achievement achievement);
    // 删除科研成果
    int deleteAchievement(@Param("achievementID") int achievementID);
    // 根据 ID 获取成果
    Achievement getAchievementById(@Param("achievementID") int achievementID);
    // 获取团队的所有科研成果
    List<Achievement> getAchievementsByTeam(@Param("teamID") int teamID);
    // 按类别搜索科研成果
    List<Achievement> searchAchievements(@Param("keyword") String keyword,
                                         @Param("category") String category);
    // 获取所有科研成果
    List<Achievement> getAllAchievements();
    // 更新科研成果状态
    int updateAchievementStatus(@Param("achievementID") int achievementID,
                                @Param("status") int status);
    // 更新科研成果的可见性
    int updateAchievementVisibility(@Param("achievementID") int achievementID,
                                    @Param("viewStatus") int viewStatus);
    int updateRefusalReason(@Param("achievementID") int achievementID,
                            @Param("refusalReason") String refusalReason);
}
