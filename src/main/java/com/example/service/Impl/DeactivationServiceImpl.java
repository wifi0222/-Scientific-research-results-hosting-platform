package com.example.service.Impl;

import com.example.mapper.DeactivationMapper;
import com.example.model.DeactivationReview;
import com.example.service.DeactivationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeactivationServiceImpl implements DeactivationService {
    @Autowired
    DeactivationMapper deactivationMapper;

    @Override
    public List<DeactivationReview> findDeactivationPendingUser() {
        return deactivationMapper.findDeactivationPendingUser();
    }

    @Override
    public int updateSuccessResult(int userID) {
        return deactivationMapper.updateSuccessResult(userID);
    }

    @Override
    public int updateFailResult(int userID) {
        return deactivationMapper.updateFailResult(userID);
    }
}
