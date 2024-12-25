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

    int updateArticle(Article article);

    int deleteArticle(@Param("articleID") int articleID);

    Article getArticleById(@Param("articleID") int articleID);

    List<Article> getArticlesByTeam(@Param("teamID") int teamID);

    List<Article> searchArticles(@Param("keyword") String keyword,
                                 @Param("category") String category);

    List<Article> getAllArticles();

    int updateArticleStatus(@Param("articleID") int articleID,
                            @Param("status") int status);
    int updateArticleVisibility(@Param("articleID") int articleID,
                                @Param("viewStatus") int viewStatus);

    int updateRefusalReason(@Param("articleID") int articleID,
                            @Param("refusalReason") String refusalReason);
}
