package com.example.mapper;

import com.example.model.Team;

import java.util.List;

public interface TeamMapper {
    public List<Team> getTeams();   //获得所有团队信息
    public int updateTeamInfo(Team team);

}
