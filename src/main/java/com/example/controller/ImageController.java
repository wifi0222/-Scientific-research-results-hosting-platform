package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.*;

@Controller
public class ImageController {
    @GetMapping("/getImage")
    @ResponseBody
    public void getImage(@RequestParam("filePath") String filePath, HttpServletResponse response) {
        File imageFile = new File(filePath);
        if (imageFile.exists() && imageFile.isFile()) {
            // 1. 设置响应类型：告知浏览器这是图片
            // 如果是 JPG，用 image/jpeg；若是 PNG，用 image/png
            response.setContentType("image/jpeg");
            try (FileInputStream fis = new FileInputStream(imageFile); OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int count;
                while ((count = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, count);
                }
                os.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            // 如果文件不存在，可以返回 404
            try {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
