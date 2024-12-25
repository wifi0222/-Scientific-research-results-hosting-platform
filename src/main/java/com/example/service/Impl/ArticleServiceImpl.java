package com.example.service.Impl;

import com.example.mapper.ArticleMapper;
import com.example.model.Article;
import com.example.service.ArticleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Override
    public List<Article> getArticlesByTeam(int teamID) {
        return articleMapper.getArticlesByTeam(teamID);
    }

    @Override
    @Transactional
    public Article insertArticle(Article article) {
        articleMapper.insertArticle(article);
        // 插入后，article 对象的 articleID 会被自动赋值
        return article;
    }

    @Override
    public Article getArticleById(int articleID) {
        return articleMapper.getArticleById(articleID);
    }

    @Override
    @Transactional
    public int updateArticle(Article article) {
        return articleMapper.updateArticle(article);
    }

    @Override
    @Transactional
    public int deleteArticle(int articleID) {
        return articleMapper.deleteArticle(articleID);
    }

    @Override
    @Transactional
    public int updateArticleVisibility(int articleID, int viewStatus) {
        return articleMapper.updateArticleVisibility(articleID, viewStatus);
    }

    @Override
    @Transactional
    public int updateArticleStatus(int articleID, int status) {
        return articleMapper.updateArticleStatus(articleID, status);
    }

    @Override
    public List<Article> searchArticles(String keyword, String category) {
        return articleMapper.searchArticles(keyword, category);
    }

    @Override
    public List<Article> getAllArticles() {
        return articleMapper.getAllArticles();
    }

    @Override
    public int updateRefusalReason(int articleID, String refusalReason) {
        return articleMapper.updateRefusalReason(articleID, refusalReason);
    }
}
