package com.example.service.Impl;

import com.example.service.ISendMailService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Random;

/**
 * 发送邮件service
 * @author tcf
 * @date 2022/04/14
 */
@Service
public class SendMailServiceImpl implements ISendMailService {
    /*private JavaMailSender javaMailSender;
    private SimpleMailMessage simpleMailMessage;*/
    /**
     *      JavaMailSenderImpl支持MimeMessages和SimpleMailMessages。
     *      MimeMessages为复杂邮件模板，支持文本、附件、html、图片等。
     *      SimpleMailMessages实现了MimeMessageHelper，为普通邮件模板，支持文本
     */

    private JavaMailSenderImpl mailSender;

    @Autowired
    public void setMailSender(JavaMailSenderImpl mailSender) {
        this.mailSender = mailSender;
    }

    /**
     * 单发
     *
     * @param recipient 收件人邮箱
     * @param subject   邮件主题
     * @param content   邮件内容
     */
    @Override
    public boolean sendEmail(String recipient){
        String send="1546854529@qq.com";
        String subject="密码重置";
        String content=verifyCode(8);
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            /** 发件人的邮箱地址 */
            messageHelper.setFrom(send);
            /** 收件人邮箱地址 */
            messageHelper.setTo(recipient);
            /** 主题 */
            messageHelper.setSubject(subject);
            /** 内容 */
            messageHelper.setText(content, true);//true代表支持html格式
            mailSender.send(mimeMessage);
            return true;
        } catch (MessagingException e) {
            return false;
        }

    }

    /*
    生成随机验证码
     */
    public static String verifyCode(int n) {
        StringBuilder strB = new StringBuilder();
        Random rand = new Random();
        for(int i = 0; i < n; i++) {
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
                default:
                    break;
            }
            strB.append((char)r2);
        }
        return strB.toString();
    }


}
