package com.example.service.Impl;

import com.example.mapper.BrowseMapper;
import com.example.model.Achievement;
import com.example.model.Article;
import com.example.model.Team;
import com.example.model.User;
import com.example.service.BrowseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrowseServiceImpl implements BrowseService {

    @Autowired
    private BrowseMapper browseMapper;

    @Override
    public Team getTeamInfo() {
        return browseMapper.getTeamInfo();
    }

    @Override
    public List<User> getTeamMembers() {
        return browseMapper.getTeamMembers();
    }

    @Override
    public List<Achievement> getAchievementsByCategory(String category) {
        return browseMapper.getAchievementsByCategory(category);
    }

    @Override
    public Achievement getAchievementDetails(int achievementID) {
        return browseMapper.getAchievementDetails(achievementID);
    }

    @Override
    public List<Article> getArticles() {
        return browseMapper.getArticles();
    }

    @Override
    public Article getArticleDetails(int articleID) {
        return browseMapper.getArticleDetails(articleID);
    }

    @Override
    public User getMemberDetails(int userID) {
        return browseMapper.getMemberDetails(userID);
    }

    // 根据年份和类别筛选文章
    @Override
    public List<Article> getArticlesByFilter(String year, String category) {
        return browseMapper.getArticlesByFilter(year, category);
    }

    // 获取所有文章的年份
    @Override
    public List<String> getAllArticleYears() {
        return browseMapper.getAllArticleYears();
    }

    // 获取所有文章的类别
    @Override
    public List<String> getAllArticleCategories() {
        return browseMapper.getAllArticleCategories();
    }

    @Override
    public List<Article> getArticlesSortedByDate(String year, String category, boolean ascending) {
        return browseMapper.getArticlesSortedByDate(year, category, ascending);
    }

    @Override
    public List<Achievement> getAchievementsByCategorySorted(String category, String year, boolean ascending) {
        return browseMapper.getAchievementsByCategorySorted(category, year, ascending);
    }

    @Override
    public List<String> getAllAchievementYears(String category) {
        return browseMapper.getAllAchievementYears(category);
    }

}
