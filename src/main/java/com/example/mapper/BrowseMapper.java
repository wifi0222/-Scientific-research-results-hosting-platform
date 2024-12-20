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
    // 根据年份和类别筛选文章
    List<Article> getArticlesByFilter(@Param("year") String year, @Param("category") String category);

    // 获取所有文章的年份
    List<String> getAllArticleYears();

    // 获取所有文章的类别
    List<String> getAllArticleCategories();

    List<Article> getArticlesSortedByDate(@Param("year") String year,
                                          @Param("category") String category,
                                          @Param("ascending") boolean ascending);

    // 根据分类、年份和排序条件获取成果
    List<Achievement> getAchievementsByCategorySorted(@Param("category") String category,
                                                      @Param("year") String year,
                                                      @Param("ascending") boolean ascending);

    // 获取指定分类的所有年份，用于筛选
    List<String> getAllAchievementYears(@Param("category") String category);
}
