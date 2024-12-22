package com.example.service.Impl;

import com.example.mapper.EmailMapper;
import com.example.service.ISendMailService;
import com.example.tool.RedisUtil;
import com.sun.mail.smtp.SMTPSendFailedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Random;

@Service
public class SendMailServiceImpl implements ISendMailService {

    private JavaMailSenderImpl mailSender;

    @Autowired
    private RedisUtil redisUtil;
    @Autowired
    private EmailMapper emailMapper; // 注入EmailMapper

    @Autowired
    public void setMailSender(JavaMailSenderImpl mailSender) {
        this.mailSender = mailSender;
    }

    /**
     * 实现接口中的方法
     * 这里只调用实际实现的方法，并传递必要参数
     */
    @Override
    public boolean checkEmail(String recipient){
        int exists = emailMapper.checkEmailExists(recipient);
        if (exists > 0) {
            System.err.println("邮箱已存在！");
            return false; // 用户名或邮箱已存在
        }
        return true;
    }

    @Override
    public boolean checkUserEmail(String recipient){
        int exists = emailMapper.checkUserEmailExists(recipient);
        if (exists > 0) {
            System.err.println("邮箱已存在！");
            return false; // 用户名或邮箱已存在
        }
        return true;
    }

    @Override
    public boolean checkUsername(String username){
        int exists = emailMapper.checkUsernameExists(username);
        if (exists > 0) {
            System.err.println("用户名已存在，无法发送验证码！");
            return false; // 用户名或邮箱已存在
        }
        return true;
    }

    @Override
    public boolean sendEmail(String username, String recipient) {

        String send = "1546854529@qq.com";
        String subject = "验证码校验";
        String content = verifyCode(8); // 生成验证码

        // 保存验证码到 Redis，而不是数据库
        try {
            String redisKey = "email:session:" + username;
            redisUtil.set(redisKey, content, 300);
            //emailMapper.insertOrUpdateCaptcha(username, content, new Date());
        } catch (Exception e) {
            System.err.println("Error occurred during insertCaptcha: " + e.getMessage());
            e.printStackTrace();
            return false;
        }


        // 发送邮件
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            messageHelper.setFrom(send);
            messageHelper.setTo(recipient);
            messageHelper.setSubject(subject);
            messageHelper.setText("您的验证码是：" + content, true);
            mailSender.send(mimeMessage);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean sendMessageEmail(String sendEmailAddress, String message) {
        String send = "1546854529@qq.com";
        String subject = "结果通知";
        // 发送邮件
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            messageHelper.setFrom(send);
            messageHelper.setTo(sendEmailAddress);
            messageHelper.setSubject(subject);
            messageHelper.setText(message, true);
            mailSender.send(mimeMessage);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            // 检查是否为目标邮箱不存在的错误
            if (e.getCause() instanceof SMTPSendFailedException) {
                SMTPSendFailedException smtpException = (SMTPSendFailedException) e.getCause();
                String errorMessage = smtpException.getMessage();

                // 如果错误信息中包含 "550" 和 "non-existent account"，则认为是邮箱不存在
                if (errorMessage.contains("550") && errorMessage.contains("non-existent account")) {
                    return false; // 邮箱不存在
                }
            }
            return false;
        }
    }

    @Override
    public String resetPassword(String recipient) {
        String send = "1546854529@qq.com";
        String subject = "密码重置";
        String content = verifyCode(8); // 生成验证码
        // 发送邮件
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            messageHelper.setFrom(send);
            messageHelper.setTo(recipient);
            messageHelper.setSubject(subject);
            messageHelper.setText("您的验证码是：" + content, true);
            mailSender.send(mimeMessage);
            return content;
        } catch (MessagingException e) {
            e.printStackTrace();
            // 检查是否为目标邮箱不存在的错误
            if (e.getCause() instanceof SMTPSendFailedException) {
                SMTPSendFailedException smtpException = (SMTPSendFailedException) e.getCause();
                String errorMessage = smtpException.getMessage();

                // 如果错误信息中包含 "550" 和 "non-existent account"，则认为是邮箱不存在
                if (errorMessage.contains("550") && errorMessage.contains("non-existent account")) {
                    return "no"; // 邮箱不存在
                }
            }
            return "no";
        }
    }


    /*
    生成随机验证码
     */
    public static String verifyCode(int n) {
        StringBuilder strB = new StringBuilder();
        Random rand = new Random();
        for (int i = 0; i < n; i++) {
            int r1 = rand.nextInt(3);
            int r2 = 0;
            switch (r1) {  // r2为ascii码值
                case 0: // 数字
                    r2 = rand.nextInt(10) + 48;  // 数字：48-57的随机数
                    break;
                case 1:
                    r2 = rand.nextInt(26) + 65;  // 大写字母
                    break;
                case 2:
                    r2 = rand.nextInt(26) + 97;  // 小写字母
                    break;
            }
            strB.append((char) r2);
        }
        return strB.toString();
    }
}
