package com.example.mapper;

import com.example.model.Article;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ArticleMapper {

    /**
     * 插入文章
     *
     * @param article 需要插入的 Article 对象
     * @return 插入操作影响的行数
     */
    int insertArticle(Article article);

    // 如果需要，可以使用单独的参数插入方法（已注释）
    // int insertArticle(@Param("title") String title,
    //                   @Param("category") String category,
    //                   @Param("abstractContent") String abstractContent,
    //                   @Param("contents") String contents,
    //                   @Param("publishDate") Date publishDate,
    //                   @Param("teamID") int teamID,
    //                   @Param("status") int status,
    //                   @Param("viewStatus") int viewStatus);

    /**
     * 更新文章
     *
     * @param article 需要更新的 Article 对象
     * @return 更新操作影响的行数
     */
    int updateArticle(Article article);

    /**
     * 删除文章
     *
     * @param articleID 需要删除的文章 ID
     * @return 删除操作影响的行数
     */
    int deleteArticle(@Param("articleID") int articleID);

    /**
     * 根据 ID 获取文章
     *
     * @param articleID 文章 ID
     * @return 对应的 Article 对象
     */
    Article getArticleById(@Param("articleID") int articleID);

    /**
     * 获取团队的所有文章
     *
     * @param teamID 团队 ID
     * @return 该团队的所有 Article 列表
     */
    List<Article> getArticlesByTeam(@Param("teamID") int teamID);

    /**
     * 按关键词和类别搜索文章
     *
     * @param keyword 关键词，用于匹配文章标题
     * @param category 文章类别
     * @return 符合条件的 Article 列表
     */
    List<Article> searchArticles(@Param("keyword") String keyword,
                                 @Param("category") String category);

    /**
     * 获取所有文章
     *
     * @return 所有 Article 的列表
     */
    List<Article> getAllArticles();

    /**
     * 更新文章状态
     *
     * @param articleID 文章 ID
     * @param status 新的状态值
     * @return 更新操作影响的行数
     */
    int updateArticleStatus(@Param("articleID") int articleID,
                            @Param("status") int status);

    /**
     * 更新文章的可见性
     *
     * @param articleID 文章 ID
     * @param viewStatus 新的可见性状态值
     * @return 更新操作影响的行数
     */
    int updateArticleVisibility(@Param("articleID") int articleID,
                                @Param("viewStatus") int viewStatus);
}
