package com.example.mapper;

import com.example.model.Question;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface QuestionMapper {

    // 插入提问
    int insertQuestion(@Param("questionContent") String questionContent,
                       @Param("userID") int userID,
                       @Param("status") int status,
                       @Param("askTime") LocalDateTime askTime);
                       //@Param("createdAt") Date createdAt);

    // 更新提问状态和回复内容
    int updateQuestionStatusAndReply(@Param("questionID") int questionID,
                                     @Param("status") int status,
                                     @Param("replyContent") String replyContent,
                                     @Param("replyTime") Date replyTime);

    // 检查某用户的提问是否存在
    int checkQuestionExists(@Param("questionID") int questionID,
                            @Param("userID") int userID);

    // 获取所有提问
    List<Question> getAllQuestions();

    // 根据状态获取提问
    List<Question> getQuestionsByStatus(@Param("status") int status);

    // 根据用户ID获取提问
    List<Question> getQuestionsByUserID(@Param("userID") int userID);

    Question getQuestionById(@Param("questionID") int questionID);

    int updateReply(@Param("questionID") int questionID,
                    @Param("replyContent") String replyContent,
                    @Param("replyTime") Date replyTime,
                    @Param("status") int status);

}
