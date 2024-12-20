package com.example.service;

import com.example.model.Question;

import java.util.Date;
import java.util.List;

public interface QuestionService {
    void submitQuestion(Question question);

    List<Question> getQuestionsByStatus(int status);

    Question getQuestionById(int questionID);

    void replyQuestion(int questionID, String replyContent, Date replyTime);

    List<Question> getQuestionsByUserID(int userID);

    void updateQuestionStatus(int questionID, int status);
}



