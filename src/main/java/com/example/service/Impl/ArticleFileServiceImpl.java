package com.example.service.Impl;

import com.example.mapper.ArticleFileMapper;
import com.example.model.ArticleFile;
import com.example.service.ArticleFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ArticleFileServiceImpl implements ArticleFileService {

    @Autowired
    private ArticleFileMapper articleFileMapper;

    @Override
    public List<ArticleFile> getFilesByArticleId(int articleID) {
        return articleFileMapper.getFilesByArticleId(articleID);
    }

    @Override
    @Transactional
    public ArticleFile insertArticleFile(ArticleFile articleFile) {
        articleFileMapper.insertArticleFile(articleFile);
        // 插入后，articleFile 对象的 fileID 会被自动赋值
        return articleFile;
    }

    @Override
    public ArticleFile getFileByFileID(int fileID) {
        return articleFileMapper.getFileByFileID(fileID);
    }

    @Override
    @Transactional
    public int deleteArticleFile(int fileID) {
        return articleFileMapper.deleteArticleFile(fileID);
    }
}
