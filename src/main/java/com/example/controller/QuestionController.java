package com.example.controller;

import com.example.model.Question;
import com.example.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/questions")
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    @PostMapping("/submit")
    public ResponseEntity<String> submitQuestion(@RequestParam("questionContent") String questionContent,
                                                 @RequestParam("userID") int userID) {
        System.out.println("Received content: " + questionContent); // 打印富文本内容

        Question question = new Question();
        question.setQuestionContent(questionContent);
        question.setUserID(userID);
        question.setStatus(0); // 设置初始状态为未回答
        question.setAskTime(LocalDateTime.now());
        questionService.submitQuestion(question);

        return ResponseEntity.ok("Question submitted successfully!");
    }

    @PostMapping("/upload-image")
    public Map<String, Object> uploadImage(@RequestParam("image") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 保存文件到本地（可以改为保存到云存储，如 AWS S3 或阿里云 OSS）
            String uploadDir = "/path/to/upload/directory";
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            File destination = new File(uploadDir + "/" + fileName);
            file.transferTo(destination);

            // 返回图片的访问 URL
            String imageUrl = "/uploads/" + fileName; // 假设通过 /uploads 映射访问
            response.put("success", true);
            response.put("imageUrl", imageUrl);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Image upload failed");
        }
        return response;
    }

    @GetMapping("/pending")
    public List<Question> getPendingQuestions() {
        return questionService.getQuestionsByStatus(0); // 查询 status = 0 的问题
    }

    @GetMapping("/{id}")
    public Question getQuestionDetails(@PathVariable("id") int questionID) {
        return questionService.getQuestionById(questionID);
    }

    @PostMapping("/{id}/reply")
    public ResponseEntity<String> replyQuestion(@PathVariable("id") int questionID,
                                                @RequestParam("replyContent") String replyContent) {
        // 处理回复逻辑
        questionService.replyQuestion(questionID, replyContent, new Date());
        return ResponseEntity.ok("Reply submitted successfully!");
    }

    @RequestMapping("/pending-questions")
    public String showPendingQuestions(Model model) {
        List<Question> questions = questionService.getQuestionsByStatus(0);
        System.out.println("in questions/pending-questions " + questions.get(0).getQuestionID() + ' ' + questions.get(0).getQuestionContent());
        model.addAttribute("questions", questions);
        return "Question/pending-questions";
    }
    @RequestMapping("/details/{id}")
    public String showQuestionDetails(@PathVariable("id") int questionID, Model model) {
        System.out.println("in questions/details/{id} " + questionID);
        Question question = questionService.getQuestionById(questionID);
        model.addAttribute("question", question);
        return "Question/question-details";
    }


}

