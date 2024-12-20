package com.example.service.Impl;

import com.example.mapper.QuestionMapper;
import com.example.model.Question;
import com.example.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {
    @Autowired
    private QuestionMapper questionMapper;

    @Override
    public void submitQuestion(Question question) {
        System.out.println("in QuestionServiceImpl.java " + question.getQuestionContent());
        question.setStatus(0); // 设置状态为未回答
        questionMapper.insertQuestion(question.getTitle(), question.getQuestionContent(),question.getUserID(), question.getStatus(), question.getAskTime());
    }

    @Override
    public List<Question> getQuestionsByStatus(int status) {
        return questionMapper.getQuestionsByStatus(status);
    }

    @Override
    public Question getQuestionById(int questionID) {
        return questionMapper.getQuestionById(questionID);
    }

    @Override
    public void replyQuestion(int questionID, String replyContent, Date replyTime) {
        questionMapper.updateReply(questionID, replyContent, replyTime, 1); // status 变为 1 表示已回复
    }

    @Override
    public List<Question> getQuestionsByUserID(int userID) {
        return questionMapper.getQuestionsByUserID(userID);
    }

    @Override
    public void updateQuestionStatus(int questionID, int status) {
        questionMapper.updateStatus(questionID, status);
    }

}
