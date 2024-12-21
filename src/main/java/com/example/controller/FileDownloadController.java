package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;

@Controller
public class FileDownloadController {

    @GetMapping("/download")
    public void downloadFile(@RequestParam("filePath") String filePath, HttpServletResponse response) {
        try {
            // 解码文件路径
            String decodedFilePath = URLDecoder.decode(filePath, StandardCharsets.UTF_8.name());

            // 判断是否为外部URL（例如：https://arxiv.org/pdf/2412.14181）
            if (decodedFilePath.startsWith("http://") || decodedFilePath.startsWith("https://")) {
                // 直接跳转到外部URL
                response.sendRedirect(decodedFilePath);
            } else {
                // 本地文件下载
                downloadLocalFile(decodedFilePath, response);
            }

        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // 从本地文件系统下载文件
    private void downloadLocalFile(String filePath, HttpServletResponse response) throws IOException {
        File file = new File(filePath);

        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 设置响应头
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment;filename=" + file.getName());

        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}
