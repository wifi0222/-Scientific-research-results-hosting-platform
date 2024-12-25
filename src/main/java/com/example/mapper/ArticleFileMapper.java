package com.example.mapper;

import com.example.model.ArticleFile;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ArticleFileMapper {

    List<ArticleFile> getFilesByArticleId(@Param("articleID") int articleID);

    ArticleFile getFileByFileID(@Param("fileID") int fileID);

    int deleteArticleFile(@Param("fileID") int fileID);

    int insertArticleFile(ArticleFile articleFile);
}
