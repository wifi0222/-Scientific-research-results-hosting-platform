package com.example.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.Date;

public interface EmailMapper {
    int insertOrUpdateCaptcha(@Param("username") String username,
                      @Param("captcha") String captcha,
                      @Param("createdAt") Date createdAt);

    int checkUsernameOrEmailExists(@Param("username") String username,
                                   @Param("email") String email);
    int checkEmailExists(@Param("email") String email);
    int checkUsernameExists(@Param("username") String username);
    int checkUserEmailExists (@Param("email") String email);
}
