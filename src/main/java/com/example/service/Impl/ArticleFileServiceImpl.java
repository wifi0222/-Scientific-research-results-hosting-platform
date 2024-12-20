package com.example.service.Impl;

import com.example.mapper.ArticleFileMapper;
import com.example.model.ArticleFile;
import com.example.service.ArticleFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleFileServiceImpl implements ArticleFileService {

    @Autowired
    private ArticleFileMapper articleFileMapper;

    @Override
    public List<ArticleFile> getFilesByArticleId(int articleID) {
        return articleFileMapper.getFilesByArticleId(articleID);
    }
}
