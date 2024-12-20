package com.example.service;

import com.example.model.ArticleFile;

import java.util.List;

public interface ArticleFileService {
    List<ArticleFile> getFilesByArticleId(int articleID);
}
