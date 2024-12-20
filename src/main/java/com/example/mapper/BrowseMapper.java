package com.example.mapper;

import com.example.model.Achievement;
import com.example.model.Article;
import com.example.model.Team;
import com.example.model.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BrowseMapper {
    Team getTeamInfo();
    List<User> getTeamMembers();
    List<Achievement> getAchievementsByCategory(@Param("category") String category);
    Achievement getAchievementDetails(@Param("achievementID") int achievementID);
    List<Article> getArticles();
    Article getArticleDetails(@Param("articleID") int articleID);
    User getMemberDetails(@Param("userID") int userID);
}
