package com.example.service.Impl;

import com.example.mapper.MemberReviewMapper;
import com.example.model.MemberReview;
import com.example.service.MemberViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberViewServiceImpl implements MemberViewService {

    @Autowired
    private MemberReviewMapper memberReviewMapper;

    @Override
    public List<MemberReview> getMemberReviews() {
        return memberReviewMapper.getAllMemberReview();
    }

    @Override
    public MemberReview findByMemberID(int memberID) {
        return memberReviewMapper.getMemberReviewById(memberID);
    }

    @Override
    public int updateSuccessResult(int memberID) {
        return memberReviewMapper.updateSuccessResult(memberID);
    }

    @Override
    public int updateFailResult(int memberID, String reason) {
        return memberReviewMapper.updateFailResult(memberID, reason);
    }

    @Override
    public int deleteSuccess(int memberID) {
        return memberReviewMapper.deleteSuccess(memberID);
    }
}
