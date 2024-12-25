package com.example.service;

import com.example.model.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleService {

    List<Article> getArticlesByTeam(int teamID);

    Article insertArticle(Article article);

    Article getArticleById(int articleID);

    int updateArticle(Article article);

    int deleteArticle(int articleID);

    int updateArticleVisibility(int articleID, int viewStatus);

    int updateArticleStatus(int articleID, int status);

    List<Article> searchArticles(String keyword, String category);

    List<Article> getAllArticles();

    int updateRefusalReason(int articleID, String refusalReason);
}
