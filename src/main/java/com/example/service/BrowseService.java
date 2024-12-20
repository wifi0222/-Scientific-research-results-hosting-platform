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
    // 根据年份和类别筛选文章
    List<Article> getArticlesByFilter(String year, String category);

    // 获取所有文章的年份
    List<String> getAllArticleYears();

    // 获取所有文章的类别
    List<String> getAllArticleCategories();

    // 获取排序后的文章列表（按时间排序）
    List<Article> getArticlesSortedByDate(String year, String category, boolean ascending);

    // 获取指定分类的所有成果并按时间排序
    List<Achievement> getAchievementsByCategorySorted(String category, String year, boolean ascending);

    // 获取该分类下的所有年份，用于筛选
    List<String> getAllAchievementYears(String category);
}
