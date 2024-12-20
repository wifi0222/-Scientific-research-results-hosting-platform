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
}
