package com.example.mapper;

import com.example.model.ArticleFile;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleFileMapper {
    List<ArticleFile> getFilesByArticleId(@Param("articleID") int articleID);
}
