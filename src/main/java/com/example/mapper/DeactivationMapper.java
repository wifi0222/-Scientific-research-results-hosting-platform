package com.example.mapper;

import com.example.model.DeactivationReview;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeactivationMapper {
    public List<DeactivationReview> findDeactivationPendingUser(); //查找所有待审核的用户
    public DeactivationReview getDeactivationReviewById(int memberID);
    public int updateSuccessResult(@Param("userID")int userID); //审核通过
    public int updateFailResult(@Param("userID")int userID); //审核不通过
}
