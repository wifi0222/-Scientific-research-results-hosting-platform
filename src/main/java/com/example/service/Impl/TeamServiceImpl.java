package com.example.service.Impl;

import com.example.mapper.TeamMapper;
import com.example.model.Team;
import com.example.service.TeamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeamServiceImpl implements TeamService {

    @Autowired
    TeamMapper teamMapper;

    @Override
    public Team getTeam() {
        return teamMapper.getTeam();
    }

    @Override
    public int updateTeamInfo(Team team) {
        return teamMapper.updateTeamInfo(team);
    }

    @Override
    public List<Team> getAllTeam() {
        return teamMapper.getAllTeam();
    }
}
