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
    public int setAllPermission(@Param("userPermission")boolean userPermission,
                                @Param("publishAchievement")boolean publishAchievement,
                                @Param("deleteAchievement")boolean deleteAchievement,
                                @Param("editAchievement")boolean editAchievement,
                                @Param("setAchievementStatus")boolean setAchievementStatus,
                                @Param("publishArticle")boolean publishArticle,
                                @Param("deleteArticle")boolean deleteArticle,
                                @Param("editArticle")boolean editArticle,
                                @Param("setArticleStatus")boolean setArticleStatus,
                                @Param("adminID")int adminID);
    public boolean getUserManageAdministrator(int adminID);
    public int setUserManageAdministrator(int adminID);
    public int setResearchAdministrator(int adminID);
    public int setArticleAdministrator(int adminID);
}
