package com.example.controller;

import com.example.util.CaptchaUtil;
//import com.google.code.kaptcha.impl.DefaultKaptcha;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
public class CaptchaController {

//    @Autowired
//    private DefaultKaptcha captchaProducer;
//
//    @GetMapping("/captcha")
//    public void getCaptcha(HttpSession session, HttpServletResponse response) throws IOException {
//        response.setDateHeader("Expires", 0);
//        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
//        response.addHeader("Cache-Control", "post-check=0, pre-check=0");
//        response.setHeader("Pragma", "no-cache");
//        response.setContentType("image/jpeg");
//
//        // 生成验证码文本并保存到 session
//        String captchaText = captchaProducer.createText();
//        session.setAttribute("captcha", captchaText);
//
//        // 输出验证码图片
//        BufferedImage captchaImage = captchaProducer.createImage(captchaText);
//        ServletOutputStream out = response.getOutputStream();
//        ImageIO.write(captchaImage, "jpg", out);
//        out.flush();
//        out.close();
//    }
    @GetMapping("/captcha")
    public void getCaptcha(HttpServletResponse response, HttpSession session) throws IOException {
        // 生成随机验证码文本
        String captchaText = CaptchaUtil.generateCaptchaText(5);

        // 保存验证码到 Session
        session.setAttribute("captcha", captchaText);

        // 设置响应头
        response.setContentType("image/jpeg");
        response.setHeader("Cache-Control", "no-cache");

        // 输出验证码图片
        CaptchaUtil.generateCaptchaImage(captchaText, response.getOutputStream());
    }
}
