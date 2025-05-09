package com.example.mapper;

import com.example.model.RegistrationReview;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface RegistrationMapper {
    String getVerificationCodeByUsername(@Param("username") String username);
    boolean usernameExists(@Param("username") String username);
    boolean emailExists(@Param("email") String email);
    int insertRegistrationRequest(@Param("username") String username,
                                  @Param("password") String password,
                                  @Param("roleType") String roleType,
                                  @Param("email") String email,
                                  @Param("reason") String reason,
                                  @Param("registrationTime") Date registrationTime,
                                  @Param("registrationStatus") int registrationStatus);
    Integer getApplicationStatusByEmail(@Param("email") String email); // 根据邮箱获取注册状态
    public List<RegistrationReview> getAllRegistrationReviews(); //获取全部注册用户列表
    public RegistrationReview getRegisterByusername(@Param("username") String username);
    public int updateSuccessResult(String username);
    public int updateFailResult(@Param("username") String username, @Param("refuseReason") String refuseReason);
}
