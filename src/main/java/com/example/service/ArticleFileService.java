package com.example.service;

import com.example.model.ArticleFile;

import java.util.List;

public interface ArticleFileService {

    List<ArticleFile> getFilesByArticleId(int articleID);

    ArticleFile getFileByFileID(int fileID);

    int deleteArticleFile(int fileID);

    // return 插入后的 ArticleFile 对象，包含生成的 fileID
    ArticleFile insertArticleFile(ArticleFile articleFile);
}
