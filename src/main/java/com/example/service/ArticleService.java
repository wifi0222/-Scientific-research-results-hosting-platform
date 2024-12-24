package com.example.service;

import com.example.model.Article;
import java.util.List;

public interface ArticleService {

    /**
     * 获取指定团队的所有文章
     *
     * @param teamID 团队 ID
     * @return 该团队的所有 Article 列表
     */
    List<Article> getArticlesByTeam(int teamID);

    /**
     * 插入新的文章
     *
     * @param article 需要插入的 Article 对象
     * @return 插入后的 Article 对象，包含生成的 articleID
     */
    Article insertArticle(Article article);

    /**
     * 根据 ID 获取文章
     *
     * @param articleID 文章 ID
     * @return 对应的 Article 对象
     */
    Article getArticleById(int articleID);

    /**
     * 更新现有的文章
     *
     * @param article 需要更新的 Article 对象
     * @return 更新操作影响的行数
     */
    int updateArticle(Article article);

    /**
     * 删除指定 ID 的文章
     *
     * @param articleID 需要删除的文章 ID
     * @return 删除操作影响的行数
     */
    int deleteArticle(int articleID);

    /**
     * 更新文章的可见性状态
     *
     * @param articleID   文章 ID
     * @param viewStatus  新的可见性状态值（0: 隐藏，1: 公开）
     * @return 更新操作影响的行数
     */
    int updateArticleVisibility(int articleID, int viewStatus);

    /**
     * 更新文章的审核状态
     *
     * @param articleID 文章 ID
     * @param status    新的审核状态值（0: 待审核，1: 审核成功，-1: 审核失败）
     * @return 更新操作影响的行数
     */
    int updateArticleStatus(int articleID, int status);

    /**
     * 按关键词和类别搜索文章
     *
     * @param keyword 关键词，用于匹配文章标题
     * @param category 文章类别（SCI\EI\核心）
     * @return 符合条件的 Article 列表
     */
    List<Article> searchArticles(String keyword, String category);

    /**
     * 获取所有文章
     *
     * @return 所有 Article 的列表
     */
    List<Article> getAllArticles();
}
