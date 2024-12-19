package com.example.mapper;

import org.apache.ibatis.annotations.Param;

public interface CaptchaMapper {
    int validateCaptcha(@Param("username") String username, @Param("captcha") String captcha);
}
