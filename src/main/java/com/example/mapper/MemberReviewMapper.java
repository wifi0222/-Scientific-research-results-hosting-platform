package com.example.mapper;

import com.example.model.MemberReview;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberReviewMapper {
    public List<MemberReview> getAllMemberReview();
    public MemberReview getMemberReviewById(int memberID);
    public int updateSuccessResult(int memberID);
    public int updateFailResult(@Param("memberID") int memberID, @Param("refuseReason") String refuseReason);
    public int deleteSuccess(int memberID);
}
