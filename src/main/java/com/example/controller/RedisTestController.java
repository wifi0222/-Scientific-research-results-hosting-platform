package com.example.controller;

import com.example.tool.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.TimeUnit;

@RestController
@RequestMapping("/test")
public class RedisTestController {

    @Autowired
    private RedisUtil redisUtil;

    @GetMapping("/redis")
    public String testRedis() {
        // 写入缓存
        redisUtil.set("testKey", "Hello Redis!");

        // 读取缓存
        String value = (String) redisUtil.get("testKey");

        return "Value from Redis: " + value;
    }
}

