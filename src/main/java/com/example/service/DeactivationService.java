package com.example.service;

import com.example.model.DeactivationReview;
import com.example.model.MemberReview;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DeactivationService {
    public List<DeactivationReview> findDeactivationPendingUser(); //查找所有待审核的用户
    public DeactivationReview findByMemberID(int memberID);
    public int updateSuccessResult(int userID); //审核通过
    public int updateFailResult(int userID); //审核不通过
}
