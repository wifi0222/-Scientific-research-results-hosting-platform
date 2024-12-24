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

    /**
     * 获取指定团队的所有文章
     *
     * @param teamID 团队 ID
     * @return 该团队的所有 Article 列表
     */
    @Override
    public List<Article> getArticlesByTeam(int teamID) {
        return articleMapper.getArticlesByTeam(teamID);
    }

    /**
     * 插入新的文章
     *
     * @param article 需要插入的 Article 对象
     * @return 插入后的 Article 对象，包含生成的 articleID
     */
    @Override
    @Transactional
    public Article insertArticle(Article article) {
        articleMapper.insertArticle(article);
        // 插入后，article 对象的 articleID 会被自动赋值
        return article;
    }

    /**
     * 根据 ID 获取文章
     *
     * @param articleID 文章 ID
     * @return 对应的 Article 对象
     */
    @Override
    public Article getArticleById(int articleID) {
        return articleMapper.getArticleById(articleID);
    }

    /**
     * 更新现有的文章
     *
     * @param article 需要更新的 Article 对象
     * @return 更新操作影响的行数
     */
    @Override
    @Transactional
    public int updateArticle(Article article) {
        return articleMapper.updateArticle(article);
    }

    /**
     * 删除指定 ID 的文章
     *
     * @param articleID 需要删除的文章 ID
     * @return 删除操作影响的行数
     */
    @Override
    @Transactional
    public int deleteArticle(int articleID) {
        return articleMapper.deleteArticle(articleID);
    }

    /**
     * 更新文章的可见性状态
     *
     * @param articleID   文章 ID
     * @param viewStatus  新的可见性状态值（0: 隐藏，1: 公开）
     * @return 更新操作影响的行数
     */
    @Override
    @Transactional
    public int updateArticleVisibility(int articleID, int viewStatus) {
        return articleMapper.updateArticleVisibility(articleID, viewStatus);
    }

    /**
     * 更新文章的审核状态
     *
     * @param articleID 文章 ID
     * @param status    新的审核状态值（0: 待审核，1: 审核成功，-1: 审核失败）
     * @return 更新操作影响的行数
     */
    @Override
    @Transactional
    public int updateArticleStatus(int articleID, int status) {
        return articleMapper.updateArticleStatus(articleID, status);
    }

    /**
     * 按关键词和类别搜索文章
     *
     * @param keyword 关键词，用于匹配文章标题
     * @param category 文章类别（SCI\EI\核心）
     * @return 符合条件的 Article 列表
     */
    @Override
    public List<Article> searchArticles(String keyword, String category) {
        return articleMapper.searchArticles(keyword, category);
    }

    /**
     * 获取所有文章
     *
     * @return 所有 Article 的列表
     */
    @Override
    public List<Article> getAllArticles() {
        return articleMapper.getAllArticles();
    }
}
