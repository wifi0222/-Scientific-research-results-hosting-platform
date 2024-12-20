package com.example.mapper;

import com.example.model.TeamAdministrator;
import org.apache.ibatis.annotations.Param;

import java.util.List;

//权限管理
public interface AdministratorMapper {
    public List<TeamAdministrator> findAllAdministrators(); //查找所有团队管理员的权限
    public TeamAdministrator findAdministratorById(@Param("adminID") int adminID);
    public int insertTeamAdminToAdministrator(@Param("adminID")int adminID);
    public int deleteTeamAdminFromAdministrator(@Param("adminID")int adminID);
    public int setTemplePermission(@Param("adminID")int adminID);
    public int setAllPermission(@Param("publishPermission")boolean publishPermission,@Param("userPermission")boolean userPermission,@Param("deletePermission")boolean deletePermission,@Param("adminID")int adminID);
}
