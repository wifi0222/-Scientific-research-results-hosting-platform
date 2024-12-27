package com.example.controller;

import com.example.model.Article;
import com.example.model.Question;
import com.example.model.User;
import com.example.service.ArticleService;
import com.example.service.QuestionService;
import com.example.tool.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/questions")
public class QuestionController {

    @Autowired
    private QuestionService questionService;
    @Autowired
    private ArticleService articleService;
    @Autowired
    private RedisUtil redisUtil;

    // 提交问题
    @PostMapping("/submit")
    public ResponseEntity<String> submitQuestion(@RequestParam("title") String title,
                                                 @RequestParam("questionContent") String questionContent,
                                                 @RequestParam("userID") int userID) {
        System.out.println("Received content: " + questionContent); // 打印富文本内容

        Question question = new Question();
        question.setTitle(title);
        question.setQuestionContent(questionContent);
        question.setUserID(userID);
        question.setStatus(0); // 设置初始状态为未回答
        question.setAskTime(new Date());
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

    // 返回待处理问题
    @GetMapping("/pending")
    public List<Question> getPendingQuestions() {
        return questionService.getQuestionsByStatus(0); // 查询 status = 0 的问题
    }

    // 根据questionID返回question详细信息
    @GetMapping("/{id}")
    public Question getQuestionDetails(@PathVariable("id") int questionID) {
        return questionService.getQuestionById(questionID);
    }

    // 处理回复逻辑
    @PostMapping("/{id}/reply")
    public ResponseEntity<String> replyQuestion(@PathVariable("id") int questionID,
                                                @RequestParam("replyContent") String replyContent) {
        // 将过期的Redis删掉
        String cacheKey = "question:" + questionID;
        redisUtil.del(cacheKey);
        // 更新数据库
        questionService.replyQuestion(questionID, replyContent, new Date());
        return ResponseEntity.ok("Reply submitted successfully!");
    }

    //将待处理问题传向前端
    @RequestMapping("/ans-all-questions")
    public String showPendingQuestions(Model model) {
        List<Question> questions = questionService.getQuestionsByStatus(0); // 得到状态为0的问题
        questions.addAll(questionService.getQuestionsByStatus(1)); // 得到状态为1的问题
        questions.addAll(questionService.getQuestionsByStatus(-1)); // 得到状态为-1的问题

        System.out.println("in questions/pending-questions " + questions.get(0).getQuestionID() + ' ' + questions.get(0).getQuestionContent());
        model.addAttribute("questions", questions);
        return "Question/ans-questions";
    }

    // 手动更新某问题的状态
    @PostMapping("/{id}/updateStatus")
    public String updateStatus(@PathVariable("id") int questionID,
                               @RequestParam("status") int status) {
        System.out.println("Received questionID: " + questionID);
        System.out.println("Received status: " + status);

        // 将过期的Redis删掉
        String cacheKey = "question:" + questionID;
        redisUtil.del(cacheKey);
        questionService.updateQuestionStatus(questionID, status);
        return "redirect:/questions/ans-details/" + questionID;
    }

    // 根据questionID返回question详细信息并传向前端
    @RequestMapping("/ans-details/{id}")
    public String showQuestionDetails(@PathVariable("id") int questionID, Model model) {
        System.out.println("in questions/ans-details/{id} " + questionID);

        // 先从 Redis 缓存中获取
        String cacheKey = "question:" + questionID;
        Question question = (Question) redisUtil.get(cacheKey);
        if (question == null) {
            // 如果缓存不存在，从数据库查询并写入缓存
            question = questionService.getQuestionById(questionID);
            redisUtil.set(cacheKey, question, 300);
        }

        model.addAttribute("question", question);
        return "Question/ans-question-details";
    }

    // 通过 userID 获取所有问题并传递给前端
    @GetMapping("/my-questions")
    public String getQuestionsByUserID(HttpSession session, Model model) {
        // 从 Session 中获取当前用户的 userID
        User currentUser = (User) session.getAttribute("currentUser");
        Integer userID = (Integer) session.getAttribute("userID");
        if (userID == null) {
            return "redirect:/user/login"; // 如果用户未登录，跳转到登录页面
        }

        // 获取该用户的所有问题
        List<Question> questions = questionService.getQuestionsByUserID(userID);
        model.addAttribute("questions", questions);
        model.addAttribute("user", currentUser);
        return "Question/ask-question-management";
    }

    // 根据questionID返回question详细信息并传向前端
    @RequestMapping("/ask-details/{id}")
    public String showQuestionDetailsToAsk(@PathVariable("id") int questionID, Model model) {
        System.out.println("in questions/ask-details/{id} " + questionID);

        // 先从 Redis 缓存中获取
        String cacheKey = "question:" + questionID;
        Question question = (Question) redisUtil.get(cacheKey);
        if (question == null) {
            // 如果缓存不存在，从数据库查询并写入缓存
            question = questionService.getQuestionById(questionID);
            redisUtil.set(cacheKey, question, 300);
        }

        model.addAttribute("question", question);
        return "Question/ask-question-details";
    }


    @PostMapping("/comment")
    public String addComment(@RequestParam("commentContent") String commentContent,
                             @RequestParam("objectID") int objectID,
                             @RequestParam("type") String type,
                             @RequestParam("title") String title,
                             HttpSession session) {
        // 从 Session 获取当前用户信息
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/user/login"; // 如果未登录，跳转到登录页面
        }

        // 创建一个新的评论对象
        Question comment = new Question();
        comment.setUserID(currentUser.getUserID());
        comment.setQuestionContent(commentContent);
        comment.setAskTime(new Date());
        comment.setType(type); // 设置评论类别
        comment.setObjectID(objectID); // 设置对应文章的 ID
        comment.setStatus(0); // 设置状态为 "待处理"
        comment.setTitle("回复了：" + title); // 设置评论的标题

        // 调用 Service 保存评论
        questionService.addComment(comment);

        return "redirect:/article/details?articleID=" + objectID; // 重定向到当前文章详情页
    }

    @GetMapping("/article/details")
    public String showArticleDetails(@RequestParam("articleID") int articleID, Model model) {
        // 查询文章详情
        Article article = articleService.getArticleById(articleID);
        model.addAttribute("article", article);

        // 根据 articleID 和 category 查询相关评论
        List<Question> comments = questionService.getCommentsByArticle(articleID, article.getCategory());
        model.addAttribute("comments", comments);

        return "article-details";
    }

}

