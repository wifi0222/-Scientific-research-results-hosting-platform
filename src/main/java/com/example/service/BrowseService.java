package com.example.service;

import com.example.model.Achievement;
import com.example.model.Article;
import com.example.model.Team;
import com.example.model.User;

import java.util.List;

public interface BrowseService {
    Team getTeamInfo();
    List<User> getTeamMembers();
    List<Achievement> getAchievementsByCategory(String category);
    Achievement getAchievementDetails(int achievementID);
    List<Article> getArticles();
    Article getArticleDetails(int articleID);
    User getMemberDetails(int userID);
}
