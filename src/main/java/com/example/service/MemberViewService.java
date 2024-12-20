package com.example.service;

import com.example.model.MemberReview;

import java.util.List;

public interface MemberViewService {
    public List<MemberReview> getMemberReviews();
    public MemberReview findByMemberID(int memberID);
    public int updateSuccessResult(int memberID);
    public int updateFailResult(int memberID, String reason);
    public int deleteSuccess(int memberID);
}
