package com.example.util;
import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.util.Random;

public class CaptchaUtil {

    private static final String CHAR_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int WIDTH = 150;
    private static final int HEIGHT = 50;

    // 生成随机验证码文本
    public static String generateCaptchaText(int length) {
        Random random = new Random();
        StringBuilder captcha = new StringBuilder();
        for (int i = 0; i < length; i++) {
            captcha.append(CHAR_STRING.charAt(random.nextInt(CHAR_STRING.length())));
        }
        return captcha.toString();
    }

    // 生成验证码图片
    public static void generateCaptchaImage(String captchaText, OutputStream outputStream) {
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = image.createGraphics();

        // 设置背景色
        graphics.setColor(Color.LIGHT_GRAY);
        graphics.fillRect(0, 0, WIDTH, HEIGHT);

        // 设置字体
        graphics.setFont(new Font("Arial", Font.BOLD, 28));

        // 绘制干扰线
        Random random = new Random();
        graphics.setColor(Color.DARK_GRAY);
        for (int i = 0; i < 5; i++) {
            int x1 = random.nextInt(WIDTH);
            int y1 = random.nextInt(HEIGHT);
            int x2 = random.nextInt(WIDTH);
            int y2 = random.nextInt(HEIGHT);
            graphics.drawLine(x1, y1, x2, y2);
        }

        // 绘制验证码文本
        graphics.setColor(Color.BLACK);
        int x = 10;
        for (char c : captchaText.toCharArray()) {
            graphics.drawString(String.valueOf(c), x, 35);
            x += 25;
        }

        // 释放资源
        graphics.dispose();

        // 将图片写入输出流
        try {
            ImageIO.write(image, "jpg", outputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
